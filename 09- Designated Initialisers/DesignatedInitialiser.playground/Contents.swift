//: Playground - noun: a place where people can play

import Foundation

class Person {
    var name :String
    var age: Int?
    var considerdDangerous = false
    init(name:String,age:Int?){
        self.name = name
        self.age = age
    }
    
    convenience init(name:String){
        self.init(name:name,age:nil)
    }
}

enum Weapon {
    case Katana, Tsuba, Shuriken , Kusarigama, Fukiya
}

class Ninja: Person {
    var weapons:[Weapon]?
    
    init(name: String, age: Int?,weapons:[Weapon]?) {
        self.weapons = weapons
        
        super.init(name: name, age: age)
        
        self.considerdDangerous = true
    }
    
    convenience init(name:String){
        self.init(name:name,age:nil,weapons:nil)
    }
}

let tony = Person(name: "tony")
tony.considerdDangerous
tony.age
tony.age = 43
tony

let tara = Person(name: "tara", age: 27)
tara.considerdDangerous
tara.age

let trevor = Ninja(name: "trevor")
trevor.age
trevor.considerdDangerous

let tina = Ninja(name:"tina", age: 23, weapons: [.Fukiya,.Tsuba])
tina.considerdDangerous
tina.weapons
tina.age



