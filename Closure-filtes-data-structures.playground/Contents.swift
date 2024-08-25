import UIKit

var greeting = "Hello, playground"
print(greeting)

//-------------------------------Classes Vs Structs-------------------------------
class myCar{
    var name: String
    var color: String
    
    init(name: String, color:String){
        self.name = name
        self.color = name
    }
}

var car = myCar(name: "Toyota", color: "rojo")
var stolenCar = car
stolenCar.color = "red"
print(car.color)

struct Car{
    var name: String
    var color: String
}

var carStru = Car(name: "Hilux", color: "Yellow")
var stolenStru = carStru
stolenStru.color = "Red"
print(carStru.color)

//-------------------------------Generics-------------------------------

func determineHigherValue<T: Comparable>(valueOne: T, valueTwo: T){
    let higherValue = valueOne > valueTwo ? valueOne : valueTwo
    print("Higher Value: \(higherValue)")
}

determineHigherValue(valueOne: 3, valueTwo: 8)
determineHigherValue(valueOne: "Sean", valueTwo: "Swift")
determineHigherValue(valueOne: Date.now, valueTwo: Date.distantFuture)

var numbersArray = Array(repeating: 3, count: 10)
var stringArray = Array(repeating: "Sean", count: 5)

numbersArray.append(4)
stringArray.append("mu")


//let user = try await NetworkManager.shared.fetchData(for: User.self, from: url)
//
//func fetchData<T: Decodable> (for: T.Type, from url: URL) async throws -> T {
//    let (data,_) = try await URLSession.shared.data (from: url)
//    do {
//        return try decoder.decode(T. self, from: data)
//    } catch {
//        throw error
//    }
//}


//-----------------------------Clousures_-----------------------------------
struct Student {
    let name: String
    var testScore: Int
}

let students = [
    Student (name: "Luke", testScore: 88),
    Student (name: "Han", testScore: 73),
    Student (name: "Leia", testScore: 95),
    Student (name: "Chewy", testScore: 78),
    Student (name: "Obi-Wan", testScore: 65),
    Student (name: "Ahsoka", testScore: 86),
    Student (name:"Yoda", testScore: 68)
]

var topStudentFilter: (Student) -> Bool = { student in
    return student.testScore > 80
}

func topStudentFilterF(student: Student) -> Bool {
    return student.testScore > 70
}

let topStudents = students.filter(topStudentFilter)

for topStudent in topStudents {
    print(topStudent.name)
}

let topStudentsOther = students.filter { student in
    return student.testScore > 80
}

let studingRanking = topStudents.sorted { $0.testScore > $1.testScore }

struct IndieApp {
    let name: String
    let monthlyPrice: Double
    let users: Int
}

var appPortfolio = [
    IndieApp(name: "Creator View", monthlyPrice: 11.99, users: 4356),
    IndieApp (name: "FitHero", monthlyPrice: 0.00, users: 1756),
    IndieApp (name: "Buckets", monthlyPrice: 3.99, users: 7598),
    IndieApp (name: "Connect Four", monthlyPrice: 1.99, users: 34081)
]


func sortUser(_ app1: IndieApp, _ app2: IndieApp)-> Bool{
    return app1.users > app2.users
}

var sortedAppPortfolio: [IndieApp] = appPortfolio.sorted(by: {$0.users > $1.users})

let freeApp = appPortfolio.filter{$0.monthlyPrice == 0.00}
let names = appPortfolio.map{$0.name}.sorted()

let numbers = [3, 5, 9, 12, 181]
let sum = numbers.reduce (100,+)

let recurringRevenue = appPortfolio.map{ $0.monthlyPrice * Double ($0.users)}.reduce(0, +)
print (recurringRevenue)

let numbersNil: [Int?] = [1,2,nil,3,nil,4]
let numberWithoutNil = numbersNil.compactMap{$0}


let matrix: [[Int]] = [[1,2,3],[4,5,6],[7,8,9]]
let array = matrix.flatMap{$0.map{$0 * 2}}


//_____________________________________Set_____________________________________

var letterSet: Set = Set<String>()
letterSet.insert("b")
letterSet.insert("a")

var upperCaseSet: Set = Set<String>()
upperCaseSet.insert("A")
upperCaseSet.insert("B")

print(letterSet.isDisjoint(with: upperCaseSet))

//_____________________________________Struct_____________________________________

struct Point: Equatable {
    var x: Int
}

struct X {
    var point: Point {
        didSet{
            point.x = 0
        }
    }
}

let y = Point (x: 5)
var p = X(point: y)
let result = p.point.x == y.x //true
print(result)

p.point.x = 5 //set 0 value due to didSet
let resultTwo = p.point.x == y.x //false
print(resultTwo)

//------------------------------------------------------------------------------------------------

/*
Given an array of numbers
    -   Return the number of zeros in the array
    -   Return an array with allFeros moved to the front of the array
*/

var input = (1...10).map{ _ in Int(arc4random_uniform(4)) };
//var input = [2,0,5,0,5]
var zerosFilter = input.filter{$0==0}.count;

var zeros = 0;
var zerosArray: [Int] = []
var elements: [Int]  = []

for element in input{
    if element == 0{
        zeros += 1
        zerosArray.append(element)
    }else{
        elements.append(element)
    }
}


//1,0,2,3,4,2
//j,i



func arrayZeros(from: [Int]) -> [Int]{
    var input = from
    var key = 0;
    var j = 0;
    var tmp = 0;
    for i in 1..<input.count{
        key = input[i];
        j = i - 1
        if (key == 0) && (input[j] != 0) {
            while (j >= 0) && (input[j] != 0) {
                tmp = input[j];
                input[j] = input[j+1];
                input[j+1] = tmp;
                j -= 1
            }
        }
    }
    return input
}

import XCTest
print(arrayZeros(from: input), zerosArray + elements)


//---------------------------------------------------------------------
var memo: [Int] = Array(repeating: 0, count: 93)

func fibonacci(n: Int) -> Int {
    if memo[n] != 0{
        return memo[n]
    }
    if n==1 || n==2 {
        memo[n] = 1
    }else{
        memo[n] = fibonacci(n: n - 1) + fibonacci(n: n - 2)
    }
    return memo[n]
}


//---------------------------------------------------------------------
var memoBtn: [Int] = Array(repeating: 0, count: 93)
memoBtn[1] = 1
memoBtn[2] = 1

func btnFibo(n: Int) -> Int{
    if memoBtn[n] != 0 {
        return memoBtn[n]
    }
    if (n<=2){
        return memoBtn[n]
    }else{
        for i in 3...n{
            memoBtn[i] = memoBtn[i - 1] + memoBtn[i - 2]
        }
    }
    return memoBtn[n]
}

fibonacci(n: 92)
btnFibo(n: 92)
print(memo)
print(memoBtn)

//---------------------------------------------------------------------

func factorial(n: Int) -> Int {
    return n==1 ? 1 : n * factorial(n: n-1)
}

for i in 1...20 {
    print(factorial(n: i))
}

//---------------------------------------------------------------------

var myString = Array("120121")
var bound:Int = Int(Double(myString.count/2).rounded(.down))

var j:Int;
var isP: Bool = true
for i in 0..<bound{
    j = myString.count - 1 - i
    if(myString[i] != myString[j]){
        isP = false
    }
}

print(isP ? "is Pallindrome" : "not Pallindrome")

//---------------------------------------------------------------------

isP = true
var stack = myString
var queue = myString

for _ in myString{
    if stack.removeFirst() != queue.removeLast(){
        isP = false
    }
}
print(isP)

//---------------------------------------------------------------------
