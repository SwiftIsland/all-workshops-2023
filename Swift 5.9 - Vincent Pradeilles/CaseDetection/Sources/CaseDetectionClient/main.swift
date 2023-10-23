import CaseDetection

@CaseDetection
enum MyEnum {
    case first
    case second
}

@CaseDetection
struct User {
    let firstName: String
    let lastName: String
}
