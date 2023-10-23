import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(URLMacroMacros)
import URLMacroMacros

let testMacros: [String: Macro.Type] = [
    "URL": URLMacro.self,
]
#endif

final class URLMacroTests: XCTestCase {
    func testMacroWithValidURL() throws {
        #if canImport(URLMacroMacros)
        assertMacroExpansion(
            """
            #URL("https://www.apple.com")
            """,
            expandedSource: """
            URL(string: "https://www.apple.com")!
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
