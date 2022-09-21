import UIKit

var greeting = "Hello, playground"

// Type out a struct Person with a name property, and create an instance with your own name

// Make a Set of Person, initialized to contain Alice and Bob.

extension Sequence where Element == Person  {
  var elementCountWhereNameCountIsOdd: Int {
    self.filter {
        $0.name.count % 2 != 0
    }.count
  }
}

typealias CompletionHandler = (_ result: Result<Person, Error>) -> Void

struct Person: Hashable {
  var name: String
  
  init(name: String) {
    self.name = name
  }
  
  static func == (lhs: Person, rhs: Person) -> Bool {
    lhs.name == rhs.name
  }

  func hash(into hasher: inout Hasher) {
      hasher.combine(name)
  }

  func downloadPerson(completion: CompletionHandler?) {
    DispatchQueue.main.async {
      completion?(.success(self))
    }
  }
}


let me = Person(name: "Akshay")

var set = Set<Person>([Person(name:"Alice"), Person(name:"Bob")])
set.insert(Person(name: "Eve"))

let colleciton = [Person(name:"Alice"), Person(name:"Bob")]
print(colleciton.elementCountWhereNameCountIsOdd)

me.downloadPerson { result in
  switch(result) {
    case .success(let person):
      print(person)
    case .failure(let error):
      print(error)
  }
}

// Make a function downloadPerson that takes a completion closure that will receive a Result of Person for the success case and Error for the failure case. Inside the function, call the completion asynchronously on the main queue. Then call that function.


// Make an extension on Array<Person> with
// Number of Person(s) with odd number of letters in name


