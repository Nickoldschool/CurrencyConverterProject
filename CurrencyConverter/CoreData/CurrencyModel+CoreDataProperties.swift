//
//  CurrencyModel+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 16.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//
//

import Foundation
import CoreData


extension CurrencyModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyModel> {
        return NSFetchRequest<CurrencyModel>(entityName: "CurrencyModel")
    }

    @NSManaged public var convertedAmount: Double
    @NSManaged public var enteredAmount: Double
    @NSManaged public var fromCurrency: String?
    @NSManaged public var toCurrency: String?

}
