//
//  ListName+CoreDataProperties.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 5/18/22.
//
//

import Foundation
import CoreData


extension ListName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListName> {
        return NSFetchRequest<ListName>(entityName: "ListName")
    }

    @NSManaged public var date: Date?
    @NSManaged public var listTitle: String?
    @NSManaged public var listCalculation: NSSet?
    
    public var unwrappedListTitle: String {
        listTitle ?? ""
    }
    public var unwrappedDate: Date {
        date ?? Date()
    }
    
    public var listCalculationArray: [ListCalculation] {
        let set = listCalculation as? Set<ListCalculation> ?? []
        
        return set.sorted {
            $0.unwrappedFullPrice < $1.unwrappedFullPrice
        }
    }

}

// MARK: Generated accessors for listCalculation
extension ListName {

    @objc(addListCalculationObject:)
    @NSManaged public func addToListCalculation(_ value: ListName)

    @objc(removeListCalculationObject:)
    @NSManaged public func removeFromListCalculation(_ value: ListName)

    @objc(addListCalculation:)
    @NSManaged public func addToListCalculation(_ values: NSSet)

    @objc(removeListCalculation:)
    @NSManaged public func removeFromListCalculation(_ values: NSSet)

}

extension ListName : Identifiable {

}
