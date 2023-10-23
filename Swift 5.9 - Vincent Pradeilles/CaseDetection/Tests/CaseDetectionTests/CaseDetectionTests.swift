import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(CaseDetectionMacros)
import CaseDetectionMacros

let testMacros: [String: Macro.Type] = [
    "CaseDetection": CaseDetectionMacro.self,
]
#endif

final class CaseDetectionTests: XCTestCase {
    func testMacro() throws {
        #if canImport(CaseDetectionMacros)
        assertMacroExpansion(
            """
            @CaseDetection
            enum MyEnum {
                case first
                case second
            }
            """,
            expandedSource: """
            
            enum MyEnum {
                case first
                case second
            
                var isFirst: Bool {
                  if case .first = self {
                    return true
                  }

                  return false
                }

                var isSecond: Bool {
                  if case .second = self {
                    return true
                  }

                  return false
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
