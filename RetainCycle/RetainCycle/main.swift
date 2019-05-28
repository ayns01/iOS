//
//  main.swift
//  RetainCycle
//
//  Created by 酒井綾菜 on 2019-05-23.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import Foundation

class Apartment {
    let unit: String
    weak var tenant: Person?
    
    init(unit: String) {
        self.unit = unit
        print("Apartment \(unit) is being initialized.")
    }
    deinit {
        print("Apartment \(unit) is being deinitialized.")
    }
}

class Person {
    let name: String
    var apartment: Apartment?
    // when creating an instance
    init(name: String) {
        self.name = name
        print("\(name) is being initialized.")
    }
    
    // when getting deinitialized
    deinit {
        print("\(name) is being deinitialized.")
    }
}

var tom: Person?
var waterfront: Apartment?

tom = Person(name: "Tom")
waterfront = Apartment(unit: "123A")

tom!.apartment = waterfront
waterfront?.tenant = tom

// property of apartment and tenant is still strong pointing to.

tom = nil
waterfront = nil

// How to resolve this problem?
//


//var person1: Person?
//var person2: Person?
//var person3: Person?
//
//person1 = Person(name: "Tom")
//person2 = person1
//person1 = nil

// strong, weak, unowned

// Unowned Reference
// Like a weak reference, an unowned reference does not
// keep a strong hold on the instance it referes to.
//

// % Use an unowned %

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
        print("CreditCard #\(number) is being initialized.")
    }
    deinit {
        print("CreditCard #\(number) is being deinitialized.")
    }
}

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
        print("\(name) is being initialized.")
    }
    deinit {
        print("\(name) is being deinitialized.")
    }
}

var tom2: Customer?
tom2 = Customer(name: "Tom")
tom2?.card = CreditCard(number: 112233445567, customer: tom2!)

// Retain cycles for Closures (Ref type)

class HTMLElements {
    let name: String? // p
    let text: String? // paragraph
    // <p>some paragraph</p>
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else {
            return "<\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
        print("\(name) is being initialized.")
    }
    deinit {
        print("\(name) is being deinitialized.")
    }
}

var heading: HTMLElements? = HTMLElements(name: "h1", text: "Welcome to website!")

print(heading?.asHTML())

heading = nil

