//
//  CurrencyConvertationEntity+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//
//

import Foundation
import CoreData


extension CurrencyConvertationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyConvertationEntity> {
        return NSFetchRequest<CurrencyConvertationEntity>(entityName: "CurrencyConvertationEntity")
    }

    @NSManaged public var convertedAmount: Double
    @NSManaged public var enteredAmount: Double
    @NSManaged public var fromCurrency: String?
    @NSManaged public var toCurrency: String?

}
