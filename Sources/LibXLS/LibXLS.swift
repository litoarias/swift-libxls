import Foundation
import libxls

// MARK: - Error

/// Errors that can be thrown when reading XLS files.
public enum XLSError: Error, LocalizedError {
    case cannotOpen
    case seekError
    case readError
    case parseError
    case mallocError
    case unsupportedEncryption
    case invalidArgument
    case invalidSheetIndex(Int)

    public var errorDescription: String? {
        switch self {
        case .cannotOpen:             return "Cannot open XLS file"
        case .seekError:              return "Seek error while reading file"
        case .readError:              return "Read error while reading file"
        case .parseError:             return "Failed to parse XLS file"
        case .mallocError:            return "Memory allocation error"
        case .unsupportedEncryption: return "File is encrypted and cannot be read"
        case .invalidArgument:        return "Invalid argument"
        case .invalidSheetIndex(let i): return "Invalid sheet index: \(i)"
        }
    }

    static func from(_ code: xls_error_t) -> XLSError {
        if code == LIBXLS_ERROR_OPEN               { return .cannotOpen }
        if code == LIBXLS_ERROR_SEEK               { return .seekError }
        if code == LIBXLS_ERROR_READ               { return .readError }
        if code == LIBXLS_ERROR_PARSE              { return .parseError }
        if code == LIBXLS_ERROR_MALLOC             { return .mallocError }
        if code == LIBXLS_ERROR_UNSUPPORTED_ENCRYPTION { return .unsupportedEncryption }
        if code == LIBXLS_ERROR_NULL_ARGUMENT      { return .invalidArgument }
        return .parseError
    }
}

// MARK: - Cell Value

/// The value stored in a spreadsheet cell.
public enum XLSCellValue: CustomStringConvertible {
    /// Empty or blank cell.
    case blank
    /// Numeric value (integers and decimals are both stored as Double in XLS).
    case number(Double)
    /// Text string.
    case text(String)
    /// Boolean value.
    case boolean(Bool)
    /// Error value (e.g. `#VALUE!`, `#REF!`).
    case error(String)

    public var description: String {
        switch self {
        case .blank:           return ""
        case .number(let d):   return d.truncatingRemainder(dividingBy: 1) == 0 ? String(Int64(d)) : String(d)
        case .text(let s):     return s
        case .boolean(let b):  return b ? "TRUE" : "FALSE"
        case .error(let e):    return e
        }
    }

    /// Returns a String representation if the value is `.text` or `.number`.
    public var stringValue: String? {
        switch self {
        case .text(let s):    return s
        case .number(let d):  return description
        case .boolean(let b): return b ? "TRUE" : "FALSE"
        default:              return nil
        }
    }

    /// Returns the numeric value if the cell contains a `.number`.
    public var doubleValue: Double? {
        if case .number(let d) = self { return d }
        return nil
    }

    /// Returns the boolean value if the cell contains a `.boolean`.
    public var boolValue: Bool? {
        if case .boolean(let b) = self { return b }
        return nil
    }

    /// `true` if the cell is blank.
    public var isBlank: Bool {
        if case .blank = self { return true }
        return false
    }
}

// MARK: - Cell

/// A single cell in a worksheet.
public struct XLSCell {
    /// Row index (0-based).
    public let row: Int
    /// Column index (0-based).
    public let column: Int
    /// The parsed value of the cell.
    public let value: XLSCellValue
    /// How many columns this cell spans (merged cells).
    public let colspan: Int
    /// How many rows this cell spans (merged cells).
    public let rowspan: Int
    /// Whether the cell is hidden.
    public let isHidden: Bool

    // Convenience accessors
    public var stringValue: String?  { value.stringValue }
    public var doubleValue: Double?  { value.doubleValue }
    public var boolValue:   Bool?    { value.boolValue }
    public var isBlank:     Bool     { value.isBlank }
}

// MARK: - Worksheet

/// A single sheet within an XLS workbook.
public final class XLSWorksheet {
    /// Name of the sheet tab.
    public let name: String
    /// Total number of rows with data.
    public let rowCount: Int
    /// Total number of columns with data.
    public let columnCount: Int

    private let pointer: UnsafeMutablePointer<xlsWorkSheet>
    // Keeps the parent workbook alive for the lifetime of this worksheet.
    private let _workbook: XLSWorkbook

    init(pointer: UnsafeMutablePointer<xlsWorkSheet>,
         name: String,
         workbook: XLSWorkbook) throws {
        self.pointer   = pointer
        self.name      = name
        self._workbook = workbook

        let result = xls_parseWorkSheet(pointer)
        guard result == LIBXLS_OK else {
            xls_close_WS(pointer)
            throw XLSError.from(result)
        }

        self.rowCount    = Int(pointer.pointee.rows.lastrow) + 1
        self.columnCount = Int(pointer.pointee.rows.lastcol) + 1
    }

    deinit {
        xls_close_WS(pointer)
    }

    // MARK: Access

    /// Returns the cell at the given row and column (0-based indices).
    public func cell(row: Int, column: Int) -> XLSCell {
        guard let cellPtr = xls_cell(pointer, WORD(row), WORD(column)) else {
            return XLSCell(row: row, column: column, value: .blank,
                           colspan: 1, rowspan: 1, isHidden: false)
        }
        return makeCell(from: cellPtr.pointee)
    }

    /// Returns all non-empty cells in a row (0-based row index).
    public func cells(inRow rowIndex: Int) -> [XLSCell] {
        guard let rowPtr = xls_row(pointer, WORD(rowIndex)) else { return [] }
        let rowData  = rowPtr.pointee
        let count    = Int(rowData.cells.count)
        guard count > 0, let cellsPtr = rowData.cells.cell else { return [] }

        return (0..<count).map { i in
            makeCell(from: cellsPtr.advanced(by: i).pointee)
        }
    }

    /// Returns every cell in the sheet as a 2-D array `[row][column]` (0-based).
    public func allCells() -> [[XLSCell]] {
        (0..<rowCount).map { r in
            (0..<columnCount).map { c in cell(row: r, column: c) }
        }
    }

    /// Iterates every row, calling `body` with the row index and its cells.
    public func forEachRow(_ body: (Int, [XLSCell]) -> Void) {
        for r in 0..<rowCount {
            body(r, cells(inRow: r))
        }
    }

    // MARK: Private helpers

    private func makeCell(from c: xlsCell) -> XLSCell {
        let id    = Int(c.id)
        let value = parseCellValue(id: id, cell: c)
        return XLSCell(
            row:      Int(c.row),
            column:   Int(c.col),
            value:    value,
            colspan:  Int(c.colspan),
            rowspan:  Int(c.rowspan),
            isHidden: c.isHidden != 0
        )
    }

    private func parseCellValue(id: Int, cell c: xlsCell) -> XLSCellValue {
        switch id {

        // Blank
        case 0x0201, 0x00BE:        // BLANK, MULBLANK
            return .blank

        // Numeric
        case 0x0203,                // NUMBER
             0x027E,                // RK
             0x00BD:                // MULRK
            return .number(c.d)

        // Text
        case 0x0204,                // LABEL
             0x00FD,                // LABELSST
             0x0207,                // STRING (follows FORMULA)
             0x00D6:                // RSTRING
            return c.str.map { .text(String(cString: $0)) } ?? .blank

        // Boolean / Error
        case 0x0205:                // BOOLERR
            if let str = c.str {
                let s = String(cString: str)
                if s.hasPrefix("#") { return .error(s) }
            }
            // l == 0: FALSE, l == 1: TRUE (iserror=0 path)
            return .boolean(c.l != 0)

        // Formula result
        case 0x0006,                // FORMULA
             0x0406:                // FORMULA_ALT (Apple Numbers)
            if let str = c.str {
                let s = String(cString: str)
                if !s.isEmpty {
                    if s.hasPrefix("#") { return .error(s) }
                    return .text(s)
                }
            }
            return .number(c.d)

        default:
            if let str = c.str {
                let s = String(cString: str)
                if !s.isEmpty { return .text(s) }
            }
            if c.d != 0 { return .number(c.d) }
            return .blank
        }
    }
}

// MARK: - Workbook

/// An XLS workbook. Wraps a libxls `xlsWorkBook` with a clean Swift API.
public final class XLSWorkbook {
    /// Number of sheets in the workbook.
    public let sheetCount: Int

    private let pointer: UnsafeMutablePointer<xlsWorkBook>

    // MARK: Init

    /// Opens an XLS file at `path`.
    public init(path: String) throws {
        var err: xls_error_t = LIBXLS_OK
        guard let wb = xls_open_file(path, "UTF-8", &err) else {
            throw XLSError.from(err)
        }
        let parseResult = xls_parseWorkBook(wb)
        guard parseResult == LIBXLS_OK else {
            xls_close_WB(wb)
            throw XLSError.from(parseResult)
        }
        self.pointer    = wb
        self.sheetCount = Int(wb.pointee.sheets.count)
    }

    /// Opens an XLS file from raw `Data`.
    public init(data: Data) throws {
        var err: xls_error_t = LIBXLS_OK
        let wb: UnsafeMutablePointer<xlsWorkBook>? = data.withUnsafeBytes { rawBuf in
            guard let base = rawBuf.baseAddress else { return nil }
            return xls_open_buffer(
                base.assumingMemoryBound(to: UInt8.self),
                data.count, "UTF-8", &err
            )
        }
        guard let wb else { throw XLSError.from(err) }
        let parseResult = xls_parseWorkBook(wb)
        guard parseResult == LIBXLS_OK else {
            xls_close_WB(wb)
            throw XLSError.from(parseResult)
        }
        self.pointer    = wb
        self.sheetCount = Int(wb.pointee.sheets.count)
    }

    deinit {
        xls_close_WB(pointer)
    }

    // MARK: Sheets

    /// Returns the worksheet at `index` (0-based), parsing it on first access.
    ///
    /// - Throws: `XLSError.invalidSheetIndex` if `index` is out of range,
    ///           or a parse error if the sheet cannot be read.
    public func sheet(at index: Int) throws -> XLSWorksheet {
        guard index >= 0 && index < sheetCount else {
            throw XLSError.invalidSheetIndex(index)
        }
        guard let ws = xls_getWorkSheet(pointer, Int32(index)) else {
            throw XLSError.parseError
        }
        let name = sheetName(at: index)
        return try XLSWorksheet(pointer: ws, name: name, workbook: self)
    }

    /// Returns all sheets in order.
    public func allSheets() throws -> [XLSWorksheet] {
        try (0..<sheetCount).map { try sheet(at: $0) }
    }

    // MARK: Metadata

    /// Returns the name of the sheet at `index`, or a fallback label.
    public func sheetName(at index: Int) -> String {
        guard let sheetsPtr = pointer.pointee.sheets.sheet,
              let namePtr   = sheetsPtr.advanced(by: index).pointee.name
        else { return "Sheet \(index + 1)" }
        return String(cString: namePtr)
    }

    /// Names of all sheets in the workbook.
    public var sheetNames: [String] {
        (0..<sheetCount).map { sheetName(at: $0) }
    }

    /// libxls version string.
    public static var version: String {
        String(cString: xls_getVersion())
    }
}
