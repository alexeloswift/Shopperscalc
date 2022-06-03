//
//  ListCalculation+CoreDataProperties.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 5/18/22.
//
//

import Foundation
import CoreData


extension ListCalculation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListCalculation> {
        return NSFetchRequest<ListCalculation>(entityName: "ListCalculation")
    }

    @NSManaged public var discountPercentage: Int16
    @NSManaged public var newTotal: Double
    @NSManaged public var fullPrice: String?
    @NSManaged public var listName: ListName?
    
    public var unwrappedFullPrice: String {
        fullPrice ?? "0.00"
    }

//    public var listOriginArray: [ListName] {
//        let set = listName as? Set<ListName> ?? []
//        
//        return set.sorted {
//            $0.unwrappedListTitle < $1.unwrappedListTitle
//        }
//    }

}

// MARK: Generated accessors for listName
extension ListCalculation {

    @objc(addListNameObject:)
    @NSManaged public func addToListName(_ value: ListCalculation)

    @objc(removeListNameObject:)
    @NSManaged public func removeFromListName(_ value: ListCalculation)

    @objc(addListName:)
    @NSManaged public func addToListName(_ values: NSSet)

    @objc(removeListName:)
    @NSManaged public func removeFromListName(_ values: NSSet)

}

extension ListCalculation : Identifiable {

}
