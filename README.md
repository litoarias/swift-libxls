# LibXLS

A Swift package for reading Excel XLS files (BIFF5/BIFF8 format) on iOS, built on top of [libxls](https://github.com/libxls/libxls).

## Requirements

- iOS 18+
- Swift 6+
- Xcode 16+

## Installation

### Swift Package Manager

Add it in Xcode via **File → Add Package Dependencies**:

```
https://github.com/litoarias/swift-libxls
```

Or add it to your `Package.swift`:

```swift
// swift-tools-version: 6.0
dependencies: [
    .package(url: "https://github.com/litoarias/swift-libxls.git", branch: "main")
]
```

## Usage

### Open a file

```swift
import LibXLS

// From Data (recommended for iOS — use security-scoped resource access)
let data = try Data(contentsOf: url)
let workbook = try XLSWorkbook(data: data)

// From a file path
let workbook = try XLSWorkbook(path: "/path/to/file.xls")
```

### Browse sheets

```swift
print(workbook.sheetNames)       // ["Sheet1", "Sheet2"]
print(workbook.sheetCount)       // 2

let sheet = try workbook.sheet(at: 0)
print(sheet.name)                // "Sheet1"
print(sheet.rowCount)            // 50
print(sheet.columnCount)         // 10
```

### Read cells

```swift
// Single cell (0-based indices)
let cell = sheet.cell(row: 0, column: 0)
print(cell.stringValue ?? "")    // "Hello"
print(cell.doubleValue ?? 0)     // 42.0

// All cells in a row
let rowCells = sheet.cells(inRow: 0)

// Entire sheet as 2-D array
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
case .blank:           break
case .number(let d):   print(d)
case .text(let s):     print(s)
case .boolean(let b):  print(b)
case .error(let e):    print(e)  // "#VALUE!"
}
```

### Opening files from the Files app or share sheet

Register `.xls` in your app's `Info.plist` and handle the URL in your SwiftUI scene:

```swift
WindowGroup {
    ContentView()
        .onOpenURL { url in
            guard url.startAccessingSecurityScopedResource() else { return }
            defer { url.stopAccessingSecurityScopedResource() }
            let data = try? Data(contentsOf: url)
            // pass data to XLSWorkbook
        }
}
```

`Info.plist` document type entry:

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

## Rebuilding the XCFramework

The prebuilt `libxls.xcframework` (libxls 1.6.2, iOS 18.0+) is included. To rebuild from source:

```bash
./build-libxls-ios.sh
```

The script clones [libxls](https://github.com/libxls/libxls), compiles for `arm64` (device) and `arm64 + x86_64` (simulator), and packages both into an XCFramework.

## License

The Swift wrapper is released under the MIT License.
libxls is licensed under the [BSD 2-Clause License](https://github.com/libxls/libxls/blob/master/LICENSE).
