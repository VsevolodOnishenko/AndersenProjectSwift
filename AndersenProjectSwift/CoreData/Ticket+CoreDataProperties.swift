//
//  Ticket+CoreDataProperties.swift
//  
//
//  Created by macbook on 08.11.17.
//
//

import Foundation
import CoreData


extension Ticket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ticket> {
        return NSFetchRequest<Ticket>(entityName: "Ticket")
    }

    @NSManaged public var airline: String?
    @NSManaged public var airlineLogo: String?
    @NSManaged public var arrivalPlace: String?
    @NSManaged public var currency: String?
    @NSManaged public var departureDate: String?
    @NSManaged public var departurePlace: String?
    @NSManaged public var expires: String?
    @NSManaged public var flightNumber: String?
    @NSManaged public var price: String?
    @NSManaged public var addDate: String?

}
