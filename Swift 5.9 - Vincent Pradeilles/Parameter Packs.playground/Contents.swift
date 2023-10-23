import Foundation
import SwiftUI

// Some of you might be familiar with the fact that in SwiftUI a view is limited
// to having 10 child views at the maximum...

// ...but look, it seems that this limitation has been lifted!

VStack {
    Text("1")
    Text("2")
    Text("3")
    Text("4")
    Text("5")
    Text("6")
    Text("7")
    Text("8")
    Text("9")
    Text("10")
    Text("11")
    Text("12")
    Text("13")
    Text("14")
}

// The limitation has recently been lifted thanks to a new Swift feature called
// Parameter Packs: let's have try and understand how it works!

// We'll take the example of a function that operates over several generic arguments

func groupInTuple<A, B, C>(_ a: A, _ b: B, _ c: C) -> (A, B, C) {
    return (a, b, c)
}

let tuple1 = groupInTuple(42, "Hello,", "world!")

//let tuple2 = groupInTuple(42, "Hello!") // ❌ we're limited to exactly two arguments

// If we want to deal with two arguments, we need to implement a new overload...

func groupInTuple<A, B>(_ a: A, _ b: B) -> (A, B) {
    return (a, b)
}

let tuple2 = groupInTuple(42, "Hello!")

// Of course, this isn't great because we need to implement a new overload
// for each amount of arguments we want to support.

// Let's try and see if we could make it work for any number of arguments!

// First approach, let's try to use a variadic argument

// It would look something like this, but there are some issues...
//func groupInTuple<T>(_ values: T...) -> (?)

// First, it would only work with arguments of the same type.
// But worst, there's no syntax to declare the type of the returned tuple
// (and there's also no syntax to build that tuple!)

// That's when parameter packs come into play 💪

func groupInTuple<each T>(_ value: repeat each T) -> (repeat each T) {
    return (repeat each value)
}

// This syntax can be confusing, so let's take it piece by piece:
// * `<each T>` declares the Parameter Pack `T` and is equivalent to `<T1, T2, T3, ..., Tn>`
// * `repeat each T` is a Pack Expansion, equivalent to either:
//   * `_ t1: T1, _ t2: T2, _ t3: T3, ..., _ tn: Tn`
//   * or to `T1, T2, T3, ..., Tn`, depending on where it's being used
// * `values` is called a Value Parameter Pack
// * `repeat each values` is a another Pack Expansion, equivalent to `(t1, t2, t3, ..., tn)`

let tupleOfOne = groupInTuple(23)
let tupleOfTwo = groupInTuple(23, "Hello!")
let tupleOfFive = groupInTuple(23, "Hello!", "Swift", "Island", "🏝️")
let tupleOfSix = groupInTuple(23, "Hello!", "Swift", "Island", "🏝️", 34.5)

// There's an interesting use case: the parameter pack allows for zero arguments

let tupleOfZero = groupInTuple()

// This might not always be what you want, however it's easy to circumvent it:
// you just need to also manually declare a generic type outside of the parameter pack.

// This change will make it mandatory to provide at least one value

func groupInNonEmptyTuple<A, each T>(_ a: A, _ value: repeat each T) -> (A, repeat each T) {
    return (a, repeat each value)
}

//let otherTupleOfZero = groupInNonEmptyTuple() // ❌ this time it doesn't work

// The syntax around Pack Expansion can be a bit confusing, so let's see a few more examples.

// Consider these two functions:

// This one returns an array of tuples: [(Int, String, String, String, String)]

func wrapInArray<each T>(_ value: repeat each T) -> Array<(repeat each T)> {
    return [(repeat each value)]
}

// [(23, "Hello!", "Swift", "Island", "🏝️")]
wrapInArray(23, "Hello!", "Swift", "Island", "🏝️")

// This one returns a tuple of arrays: ([Int], [String], [String], [String], [String)]

func otherWrapInArray<each T>(_ value: repeat each T) -> (repeat Array<each T>) {
    return (repeat [each value])
}

// ([23], ["Hello!"], ["Swift"], ["Island"], ["🏝️"])
otherWrapInArray(23, "Hello!", "Swift", "Island", "🏝️")

// We can also go further and:
// * add generic constraints to Parameter Packs
// * use Value Parameter Packs to call properties on each items

func firsts<each T: Collection>(_ collection: repeat each T) -> (repeat (each T).Element) {
    return (repeat (each collection).first!)
}

// (1, "a")
firsts([1, 2, 3], ["a", "b", "c"])

// Note that we can also use a Type Parameter Pack in a `where` clause:

func alternateFirsts<each T>(
    _ collection: repeat each T
) -> (repeat (each T).Element) where repeat each T: Collection {
    return (repeat (each collection).first!)
}

// (1, "a")
alternateFirsts([1, 2, 3], ["a", "b", "c"])

// Now it's your turn!

// Let's try to build a `makePairs()` function that would be called as follows:
// `makePairs(firsts: 1, 2, "c", "d", seconds: "a", "b", 3, 4)`, and would return:
// `[(1, "a"), (2, "b"), ("c", 3), ("d", 4)]`

func makePairs<each First, each Second>(
    firsts: repeat each First,
    seconds: repeat each Second
) -> (repeat (each First, each Second)) {
    return (repeat (each firsts, each seconds))
}

makePairs(firsts: 1, 2, "c", "d", seconds: "a", "b", 3, 4)

// Let's try build a `zip()` function that takes an arbitrary number of Optionals and:
// * if all optionals have a value, returns a tuple of all these values
// * if one optional is `nil`, returns a `nil`

func zip<each T>(_ optional: repeat (each T)?) -> (repeat each T)? {
    do {
        return (repeat try (each optional).unwrapOrThrow())
    } catch {
        return nil
    }
}

struct UnwrapError: Error {}

extension Optional {
  func unwrapOrThrow() throws -> Wrapped {
      switch self {
      case .none:
          throw UnwrapError()
      case .some(let wrapped):
          wrapped
      }
  }
}

// Let's see if it works!

zip(2, 7, "Hello", 42.0)
zip(2, 7, "Hello", nil as Double?)
zip(2, 7, "Hello", Bool.random() ? 42.0 : nil)

// You might want to use the same approach to zip sequences, but it won't work,
// because you can't call a mutating method like `Iterator.next()` on a Value Pack

// You might want to also try to zip the specific case of Arrays, but it also won't
// work, because you also can't iterate over a Value Pack.

// For now, Value Pack Expansion can only be used inside a function argument list or
// a tuple, so this quickly brings in a strong amount of limitations 🙃

// But actually that's not the whole truth! Because while there indeed is no syntax
// to iterate over the Value Pack, it's still possible to collect the values in a
// tuple and iterate over the members of that tuple by using reflection!

func totalCount<each C: Collection>(_ collection: repeat each C) -> Int {
    let collectionsTuple = (repeat each collection)
    
    let mirror = Mirror(reflecting: collectionsTuple)
    
    let children = mirror.children
            
    let collections = children.compactMap { $0.value as? any Collection }
    
    let counts = collections.map(\.count)
    
    let totalCount = counts.reduce(0, +)
    
    return totalCount
}

// However be very careful, because this approach seems to work...

totalCount(
    [1, 2, 3],
    ["Hello", "Swift Island!"]
)

totalCount(
    [1, 2, 3],
    ["Hello", "Swift Island!"],
    [42.0, 100.0, 0.0]
)

// ...until it doesn't:

totalCount(
    [1, 2, 3]
)

// Here the reason is that when the tuple contain only a single array, then
// the collection is automatically flattened and the `children` becimes the elements
// of the array instead of the array itself.

// To learn more about these limitations, I recommend reading the Swift Evolution Proposal:
// https://github.com/apple/swift-evolution/blob/main/proposals/0393-parameter-packs.md
