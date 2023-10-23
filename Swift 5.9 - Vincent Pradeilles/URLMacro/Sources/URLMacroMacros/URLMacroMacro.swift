import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

enum CustomError: Error, CustomStringConvertible {
   case message(String)

   var description: String {
     switch self {
     case .message(let text):
       return text
     }
   }
 }

public struct URLMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.argumentList.first?.expression,
              let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
              segments.count == 1,
              case .stringSegment(let literalSegment)? = segments.first
        else {
          throw CustomError.message("#URL requires a static string literal")
        }
        
        // Test whether the string can be parsed into a URL
        guard let _ = URL(string: literalSegment.content.text) else {
          throw CustomError.message("malformed url: \(argument)")
        }
         
        // If so, it's then safe to force unwrap!
        return "URL(string: \(argument))!"
    }
}

@main
struct URLMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        URLMacro.self,
    ]
}
