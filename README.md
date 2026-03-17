# swift-libxls

**Swift Package for reading legacy Excel `.xls` files on iOS** — built on top of [libxls](https://github.com/libxls/libxls) (BIFF5/BIFF8 format), fully compatible with Swift 6 and iOS 18+.

> Read Excel 97–2004 `.xls` files natively in your iOS app without any third-party server or paid SDK. Supports files opened from the Files app, share sheets, iCloud Drive, or loaded directly from `Data`.

---

## Features

- Read `.xls` files (Excel 97–2004, BIFF5/BIFF8)
- Open from `Data` (recommended for iOS sandboxed file access) or from a file path
- Access multiple sheets, cell values (text, number, boolean, error, blank)
- Merged cell support (`colspan`, `rowspan`)
- Hidden cell detection
- Formula result reading
- Full Swift 6 concurrency compatibility
- Zero external dependencies at runtime (XCFramework included)

---

## Requirements

| | Minimum |
|---|---|
| iOS | 18.0 |
| Swift | 6.0 |
| Xcode | 16.0 |
| Swift Tools Version | 6.0 |

---

## Installation

### Swift Package Manager

**Via Xcode:** File → Add Package Dependencies and enter:

```
https://github.com/litoarias/swift-libxls
```

**Via `Package.swift`:**

```swift
// swift-tools-version: 6.0
dependencies: [
    .package(url: "https://github.com/litoarias/swift-libxls.git", branch: "main")
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["LibXLS"]
    )
]
```

---

## Usage

### Open a workbook

```swift
import LibXLS

// From Data — recommended on iOS (use security-scoped resource access)
let data = try Data(contentsOf: url)
let workbook = try XLSWorkbook(data: data)

// From a file path
let workbook = try XLSWorkbook(path: "/path/to/file.xls")
```

### Browse sheets

```swift
print(workbook.sheetCount)       // 3
print(workbook.sheetNames)       // ["Empleados", "Turnos", "Resumen"]

let sheet = try workbook.sheet(at: 0)
print(sheet.name)                // "Empleados"
print(sheet.rowCount)            // 120
print(sheet.columnCount)         // 8

// Load all sheets at once
let sheets = try workbook.allSheets()
```

### Read cells

```swift
// Single cell (0-based row and column)
let cell = sheet.cell(row: 0, column: 0)
print(cell.stringValue ?? "")    // "Nombre"
print(cell.doubleValue ?? 0)     // 0.0

// All cells in a row
let headers = sheet.cells(inRow: 0)

// Entire sheet as a 2-D array [row][column]
let grid = sheet.allCells()      // [[XLSCell]]

// Iterate row by row
sheet.forEachRow { rowIndex, cells in
    for cell in cells {
        print("[\(cell.row),\(cell.column)] \(cell.value)")
    }
}
```

### Cell value types

```swift
switch cell.value {
case .blank:
    break
case .number(let d):
    print(d)                     // 42.0
case .text(let s):
    print(s)                     // "Juan García"
case .boolean(let b):
    print(b)                     // true
case .error(let e):
    print(e)                     // "#VALUE!"
}
```

### Convenience accessors on `XLSCell`

```swift
cell.stringValue   // String? — text and numbers coerced to String
cell.doubleValue   // Double? — only for .number cells
cell.boolValue     // Bool?   — only for .boolean cells
cell.isBlank       // Bool
cell.colspan       // Int — merged columns
cell.rowspan       // Int — merged rows
cell.isHidden      // Bool
```

### Error handling

```swift
do {
    let workbook = try XLSWorkbook(data: data)
    let sheet    = try workbook.sheet(at: 0)
    // ...
} catch XLSError.cannotOpen {
    print("Could not open file")
} catch XLSError.unsupportedEncryption {
    print("File is password-protected")
} catch XLSError.invalidSheetIndex(let i) {
    print("No sheet at index \(i)")
} catch {
    print(error.localizedDescription)
}
```

**All error cases:**

| Case | Description |
|---|---|
| `cannotOpen` | File not found or unreadable |
| `seekError` | Seek error while reading |
| `readError` | Read error while reading |
| `parseError` | Invalid or corrupted XLS data |
| `mallocError` | Memory allocation failure |
| `unsupportedEncryption` | File is password-protected |
| `invalidArgument` | Null or invalid argument passed |
| `invalidSheetIndex(Int)` | Sheet index out of range |

---

## Opening `.xls` files from the Files app or share sheet

Register the `.xls` document type in `Info.plist` and handle the URL in your SwiftUI scene.

### `Info.plist`

```xml
<key>CFBundleDocumentTypes</key>
<array>
    <dict>
        <key>CFBundleTypeName</key>
        <string>Microsoft Excel 97-2004</string>
        <key>CFBundleTypeRole</key>
        <string>Viewer</string>
        <key>LSHandlerRank</key>
        <string>Alternate</string>
        <key>LSItemContentTypes</key>
        <array>
            <string>com.microsoft.excel.xls</string>
        </array>
    </dict>
</array>
```

### SwiftUI scene

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    guard url.startAccessingSecurityScopedResource() else { return }
                    defer { url.stopAccessingSecurityScopedResource() }

                    guard let data = try? Data(contentsOf: url),
                          let workbook = try? XLSWorkbook(data: data)
                    else { return }

                    // process workbook…
                }
        }
    }
}
```

---

## Real-world usage

**swift-libxls** is used in production in [TurnoQuiron](https://apps.apple.com/app/turnoquiron) — an iOS app for healthcare shift management that imports legacy staff schedule files exported from Excel 97–2004.

---

## Supported Excel cell types

| Excel type | `XLSCellValue` case |
|---|---|
| Empty / blank | `.blank` |
| Number, integer, decimal | `.number(Double)` |
| Text / label | `.text(String)` |
| Boolean | `.boolean(Bool)` |
| Error (`#VALUE!`, `#REF!`, …) | `.error(String)` |
| Formula (evaluated result) | `.number` / `.text` / `.error` |

> This library reads **BIFF5 and BIFF8** formats (Excel 5.0 / 95 / 97 / 2000 / XP / 2003). It does **not** support `.xlsx` (Office Open XML) or password-protected files.

---

## Rebuilding the XCFramework

The prebuilt `libxls.xcframework` (libxls 1.6.2, iOS 18.0+, `arm64` device + `arm64`/`x86_64` simulator) is included in the repository. To rebuild from source:

```bash
./build-libxls-ios.sh
```

The script clones [libxls](https://github.com/libxls/libxls), compiles for `arm64` (device) and `arm64 + x86_64` (Simulator), links system `libiconv`, and packages both slices into an XCFramework.

---

## API Reference

### `XLSWorkbook`

| Member | Description |
|---|---|
| `init(path:)` | Open from file path |
| `init(data:)` | Open from `Data` |
| `sheetCount: Int` | Total number of sheets |
| `sheetNames: [String]` | All sheet tab names |
| `sheet(at:) throws` | Load a sheet by index |
| `allSheets() throws` | Load all sheets |
| `sheetName(at:)` | Name of a sheet by index |
| `XLSWorkbook.version` | libxls version string |

### `XLSWorksheet`

| Member | Description |
|---|---|
| `name: String` | Sheet tab name |
| `rowCount: Int` | Number of rows |
| `columnCount: Int` | Number of columns |
| `cell(row:column:)` | Single cell (0-based) |
| `cells(inRow:)` | All cells in a row |
| `allCells()` | Full 2-D grid `[[XLSCell]]` |
| `forEachRow(_:)` | Row-by-row iteration |

### `XLSCell`

| Member | Type | Description |
|---|---|---|
| `row` | `Int` | Row index (0-based) |
| `column` | `Int` | Column index (0-based) |
| `value` | `XLSCellValue` | Parsed cell value |
| `stringValue` | `String?` | Text or number as String |
| `doubleValue` | `Double?` | Numeric value |
| `boolValue` | `Bool?` | Boolean value |
| `isBlank` | `Bool` | True if blank |
| `colspan` | `Int` | Merged column span |
| `rowspan` | `Int` | Merged row span |
| `isHidden` | `Bool` | Hidden cell flag |

---

## License

The Swift wrapper is released under the **MIT License**.
libxls is licensed under the [BSD 2-Clause License](https://github.com/libxls/libxls/blob/master/LICENSE).
