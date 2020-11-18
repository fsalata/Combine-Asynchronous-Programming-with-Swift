import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "min") {
    let publisher = [1, -50, 246, 0].publisher
    
    publisher
        .print("Publisher")
        .min()
        .sink(receiveValue: {  print("Lowest value is \($0)") })
        .store(in: &subscriptions)
}

example(of: "min non-Comparable") {
    let publisher = ["12345", "ab", "Hello World"]
        .compactMap { $0.data(using: .utf8) }
        .publisher
    
    publisher
        .print("publisher")
        .min(by: { $0.count < $1.count })
        .sink { data in
            let string = String(data: data, encoding: .utf8)!
            print("Smallest data is \(string), \(data.count) bytes")
        }
        .store(in: &subscriptions)
}

example(of: "max") {
    let publisher = ["A", "F", "Z", "E"].publisher
    
    publisher
        .print("publisher")
        .max()
        .sink { print("Highest value is \($0)") }
        .store(in: &subscriptions)
}

example(of: "first") {
    let publisher = ["a", "b", "c"].publisher
    
    publisher
        .print("publisher")
        .first()
        .sink { print("First value is \($0)") }
        .store(in: &subscriptions)
}

example(of: "first(here:)") {
    let publisher = ["j", "o", "H", "n"].publisher
    
    publisher
        .print("publisher")
        .first(where: { "Hello World".contains($0) })
        .sink { print("First value is \($0)") }
        .store(in: &subscriptions)
}

example(of: "last") {
    let publisher = ["a", "b", "c"].publisher
    
    publisher
        .print("publisher")
        .last()
        .sink { print("Last value is \($0)") }
        .store(in: &subscriptions)
}

example(of: "output(at:)") {
    let publisher = ["a", "b", "c"].publisher
    
    publisher
        .print("publisher")
        .output(at: 1)
        .sink { print("Value at index 1 is \($0)") }
        .store(in: &subscriptions)
}

example(of: "output(in:)") {
    let publisher = ["a", "b", "c", "d", "e"].publisher
    
    publisher
        .print("publisher")
        .output(in: 1...3)
        .sink { print("Value in range: \($0)") }
        .store(in: &subscriptions)
}

example(of: "count") {
    let publisher = ["a", "b", "c"].publisher
    
    publisher
        .print("publisher")
        .count()
        .sink { print("I have \($0) items") }
        .store(in: &subscriptions)
}

example(of: "contains") {
    let publisher = ["a", "b", "c", "d", "e"].publisher
    let letter = "c"
    
    publisher
        .print("publisher")
        .contains(letter)
        .sink { print("Contains c? \($0)") }
        .store(in: &subscriptions)
}

example(of: "contains(where:)") {
    struct Person {
        let id: Int
        let name: String
    }
    
    let people = [
        (id: 456, name: "Scott"),
        (id: 123, name: "Shai"),
        (id: 777, name: "Marin"),
        (id: 214, name: "Florent")
    ]
    .map(Person.init)
    .publisher
    
    people
        .contains(where: { $0.id == 800 || $0.name == "Marin" })
        .sink { contains in
            print(contains ? "Criteria matches!" : "Couldn't find a match for the criteria")
        }
        .store(in: &subscriptions)
}

example(of: "allSatisfy") {
    // 1
    let publisher = stride(from: 0, to: 5, by: 2).publisher
    
    // 2
    publisher
        .print("publisher")
        .allSatisfy { $0 % 2 == 0 }
        .sink(receiveValue: { allEven in
            print(allEven ? "All numbers are even"
                    : "Something is odd...")
        })
        .store(in: &subscriptions)
}

example(of: "reduce") {
    let publisher = ["Hel", "lo", " ", "Wor", "ld", "!"].publisher
    
    publisher
        .print("publisher")
        .reduce("", +)
        .sink { print("Reduced into: \($0)") }
        .store(in: &subscriptions)
}





/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
