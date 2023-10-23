import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

extension TokenSyntax {
    fileprivate var initialUppercased: String {
        let name = self.text
        guard let initial = name.first else {
            return name
        }
        
        return "\(initial.uppercased())\(name.dropFirst())"
    }
}

enum CaseDetectionError: Error, CustomStringConvertible {
    case notAnEnum
    
    var description: String {
        switch self {
        case .notAnEnum:
            "CaseDetection can only be applied to an enum"
        }
    }
}

public struct CaseDetectionMacro: MemberMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        guard let _ = declaration.as(EnumDeclSyntax.self) else {
            throw CaseDetectionError.notAnEnum
        }
        
        return declaration.memberBlock.members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
            .map { $0.elements.first!.name }
            .map { ($0, $0.initialUppercased) }
            .map { original, uppercased in
              """
              var is\(raw: uppercased): Bool {
                if case .\(raw: original) = self {
                  return true
                }
              
                return false
              }
              """
            }
    }
}

@main
struct CaseDetectionPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        CaseDetectionMacro.self,
    ]
}
