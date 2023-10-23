import Foundation
import URLMacro

let a = 17
let b = 25

let result = #URL("https://www.apple.com")

let end = ".com"

let badResult = #URL("https://www.apple\(end)")

