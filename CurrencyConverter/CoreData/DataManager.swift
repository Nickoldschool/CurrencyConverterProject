//
//  DataManager.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 16.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    // MARK: - Core Data stack
    
    private enum Keys {
        static let currencyConvertation = "CurrencyConvertationEntity"
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CurrencyConvertationStorage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        return context
    }()
    
    // MARK: - Core Data Saving 
    
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Methods
    
    func entityForName(_ name: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: name, in: self.managedObjectContext)!
    }
    
    // MARK: - CurrencyConvertation CRUD
    
    private func createCurrencyConvertation(_ currencyConvertation: CurrencyConvertation) {
        
        let newCurrencyConvertation = NSEntityDescription.insertNewObject(forEntityName: Keys.currencyConvertation,
                                                                          into: managedObjectContext) as! CurrencyConvertationEntity
        
        newCurrencyConvertation.fromCurrency = currencyConvertation.fromCurrency
        newCurrencyConvertation.toCurrency = currencyConvertation.toCurrency
        newCurrencyConvertation.enteredAmount = currencyConvertation.enteredAmount
        newCurrencyConvertation.convertedAmount = currencyConvertation.convertedAmount
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to create credit card: \(error)")
        }
    }
    
    private func retrieveCurrencyConvertation() -> [CurrencyConvertation]? {
        
        let fetchRequest = NSFetchRequest<CurrencyConvertationEntity>(entityName: Keys.currencyConvertation)
        do {
            let currencies = try managedObjectContext.fetch(fetchRequest)
            
            var result: [CurrencyConvertation] = []
            for currency in currencies {
                guard let fromCurrency = currency.fromCurrency,
                      let toCurrency = currency.toCurrency else { return nil }
                let currencyModel = CurrencyConvertation(fromCurrency: fromCurrency,
                                                         toCurrency: toCurrency,
                                                         enteredAmount: currency.enteredAmount,
                                                         convertedAmount: currency.convertedAmount)
                result.append(currencyModel)
            }
            return result
        } catch {
            print("Failed to get credit card: \(error)")
        }
        return nil
    }
    
    private func deleteCurrencyConvertation(_ fromCurrency: String,
                                            _ toCurrency: String,
                                            _ enteredAmount: String,
                                            _ convertedAmount: String) {
        
        let fetchRequest = NSFetchRequest<CurrencyConvertationEntity>(entityName: Keys.currencyConvertation)
        fetchRequest.predicate = NSPredicate(format: "fromCurrency == %@ && toCurrency == %@ && enteredAmount == %@ && convertedAmount == %@",                                  fromCurrency, toCurrency, enteredAmount, convertedAmount)
        do {
            if let card = try managedObjectContext.fetch(fetchRequest).first {
                managedObjectContext.delete(card)
                try managedObjectContext.save()
            }
        } catch {
            print("Failed to delete credit card: \(error)")
        }
    }
    
    
    func deleteAllInstancesOf(entity: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
}