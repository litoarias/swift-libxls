# LibXLS

A Swift package for reading Excel XLS files (BIFF5/BIFF8 format) on iOS, built on top of [libxls](https://github.com/libxls/libxls).

## Requirements

- iOS 13+
- Swift 5.9+

## Installation

### Swift Package Manager

Add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/litoarias/swift-libxls.git", from: "1.0.0")
]
```

Or add it in Xcode via **File → Add Package Dependencies**.

## Usage

### Open a file

```swift
import LibXLS

// From a file path
let workbook = try XLSWorkbook(path: "/path/to/file.xls")

// From Data
let data = try Data(contentsOf: url)
let workbook = try XLSWorkbook(data: data)
```

### Browse sheets

```swift
print(workbook.sheetNames)          // ["Sheet1", "Sheet2"]
print(workbook.sheetCount)          // 2

let sheet = try workbook.sheet(at: 0)
print(sheet.name)                   // "Sheet1"
print(sheet.rowCount)               // e.g. 50
print(sheet.columnCount)            // e.g. 10
```

### Read cells

```swift
// Single cell (0-based indices)
let cell = sheet.cell(row: 0, column: 0)
print(cell.value)                   // XLSCellValue
print(cell.stringValue ?? "")       // "Hello"
print(cell.doubleValue ?? 0)        // 42.0

// All cells in a row
let rowCells = sheet.cells(inRow: 0)

// Entire sheet as 2-D array
let grid = sheet.allCells()         // [[XLSCell]]

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
case .blank:           break
case .number(let d):   print(d)
case .text(let s):     print(s)
case .boolean(let b):  print(b)
case .error(let e):    print(e)   // e.g. "#VALUE!"
}
```

## Rebuilding the XCFramework

The prebuilt `libxls.xcframework` (libxls 1.6.2) is included. To rebuild it from source:

```bash
./build-libxls-ios.sh
```

## License

The Swift wrapper is released under the MIT License.
libxls is licensed under the [BSD 2-Clause License](https://github.com/libxls/libxls/blob/master/LICENSE).
