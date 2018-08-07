//
//  Person+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by Dragos-Robert Neagu on 07/08/2018.
//  Copyright © 2018 Dragos-Robert Neagu. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
