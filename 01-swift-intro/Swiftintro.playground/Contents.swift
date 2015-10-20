//: Playground - noun: a place where people can play

import UIKit
/*******************
MUTABILITY
******************/

struct MyStruct{
    let t:Int
    var u:String
}

var struct1 = MyStruct(t: 15, u: "Hello")
//struct1.t = 11
struct1.u = "GoodBye"
struct1 = MyStruct(t: 10, u: "You")

let struct2 = MyStruct(t: 12, u: "World")
//struct2.t = 12
//struct2.u = MyStruct(t: 2, u: "kk")

class MyClass {
    let t:Int
    var u:String
    init(t:Int,u:String){
        self.t = t
        self.u = u
    }
}

var class1 = MyClass(t: 15, u: "Hello")
//class1.t = 13
class1 = MyClass(t: 12, u: "You")

let class2 = MyClass(t: 12, u: "World")
class2.u = "Plant"
//class2 = MyClass(t: 11, u: "Geoid")

var array1 = [1,2,3,4]
array1.append(5)
array1[1] = 27
array1
array1 = [5,7]

let array2 = [4,3,2,1]
//array2.append(0)
//array2[2] = 36
//array2 = [5,6]

/*******************
AnyObject
******************/

let myString:AnyObject = "hello"
myString.cornerRadius

func someFunc(parametter:AnyObject!){
    if let castedparametter = parametter as? NSString{
        
    }
}

func  someOtherFunc(parametter:AnyObject!){
    let castedparametter = parametter as! NSString
}

func someArrayFunc(parametter:[AnyObject]!){
    let newArray = parametter as! [NSString]
    
}


/*******************
Protocols
******************/

protocol MyProtocol{
    func myProtocolFunc()->Bool
}

if let classAsProtocal  = class1 as? MyProtocol{
    class1.u
}else{
    class1.t
}

@objc protocol MyNewProtocol{
    func myProtocolFunc()->Bool
}

if let classNewAsProtocal  = class1 as? MyProtocol{
    class1.u
}else{
    class1.t
}

/*******************
Enums
******************/
enum MyEnum{
    case FirstType
    case IntType(Int)
    case StringType(String)
    case TupleType(Int,String)
    
    func prettyFormat()->String{
        switch self{
        case .FirstType:
            return "No params"
        case  .IntType(let value ):
            return "One param : \(value)"
        case .StringType(let value):
            return "One param : \(value)"
        case .TupleType(let v1 , let v2):
            return "Two params : \(v1) , \(v2)"
        default:
            return "Nothing to see here"
        }
    }
}

var enum1 = MyEnum.FirstType
enum1.prettyFormat()
enum1 = .TupleType(12, "Hello")
enum1.prettyFormat()














