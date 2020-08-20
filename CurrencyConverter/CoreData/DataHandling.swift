//
//  DataHandling.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 04.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit
import CoreData

class DataHandling {
    
    // MARK: - Core Data stack
    
    private enum Keys {
        static let currencyConvertation = "CurrencyConvertationStorage"
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Keys.currencyConvertation)
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

    func addCurrencyRecord(fromCurrency: String, toCurrency: String, enteredAmount: Double, convertedAmount: Double){

        //3. Create an entity
        if let currenciesEntity = NSEntityDescription.entity(forEntityName: "CurrencyConvertationEntity", in: managedObjectContext){
            //4. Create managed object
            let currency = NSManagedObject(entity: currenciesEntity, insertInto: managedObjectContext)
            currency.setValue(fromCurrency, forKey: "fromCurrency")
            currency.setValue(toCurrency, forKey: "toCurrency")
            currency.setValue(enteredAmount, forKey: "enteredAmount")
            currency.setValue(convertedAmount, forKey: "convertedAmount")

        }

       //5. Save to persistent store
        if managedObjectContext.hasChanges{
            do {
                try managedObjectContext.save()
                print("Save \(fromCurrency)")
                print("Save \(toCurrency)")
                print("Save \(enteredAmount)")
                print("Save \(convertedAmount)")
            } catch let error as NSError{
                print("not Save==\(error),\(error.userInfo)")
            }
        }

    }

    func fetchAllRecords(){
        
        //3. Creating fetch request using this we can only filter NSManagedObject having entity name Currency.
        let fetchRequest = NSFetchRequest<CurrencyConvertationEntity>(entityName: "CurrencyConvertationEntity")

        do{
            //4. Execute request
            let currencies = try managedObjectContext.fetch(fetchRequest)
            for (index,currency) in currencies.enumerated(){
            //5. Access Data
                print("\(index). \(currency.value(forKey: "fromCurrency") ?? "No Name Available")")
                print("\(index). \(currency.value(forKey: "toCurrency") ?? "No Name Available")")
                print("\(index). \(currency.value(forKey: "enteredAmount") ?? "No Name Available")")
                print("\(index). \(currency.value(forKey: "convertedAmount") ?? "No Name Available")")
            }
        } catch let error as NSError{
            print("not fetch==\(error),\(error.userInfo)")
        }
    }

    func deleteRecord(){

        //3. Creating fetch request using this we can only filter NSManagedObject having entity name Currency.
        let fetchRequest = NSFetchRequest<CurrencyConvertationEntity>(entityName: "CurrencyConvertationEntity")

        do{
            //4. Access Revords
            let currencies = try managedObjectContext.fetch(fetchRequest)

            for currency in currencies{
            //5. Delete Record
                managedObjectContext.delete(currency)
                print("Deleted \(currency.value(forKey: "fromCurrency") ?? "No Name Available")")
                print("Deleted \(currency.value(forKey: "toCurrency") ?? "No Name Available")")
                print("Deleted \(currency.value(forKey: "enteredAmount") ?? "No Name Available")")
                print("Deleted \(currency.value(forKey: "convertedAmount") ?? "No Name Available")")
            }
        } catch let error as NSError{
            print("not deleted==\(error),\(error.userInfo)")
        }

        if managedObjectContext.hasChanges{
            do{
                //6. Commit changes
                try managedObjectContext.save()
            }catch let error as NSError{
                print("not save==\(error),\(error.userInfo)")
            }
        }

    }
}

//MARK: - USAGE
//
//let dataHandling = DataHandling()
//
//dataHandlingObj.addCurrencyRecord(fromCurrency: String, toCurrency: String, enteredAmount: Double, convertedAmount: Double)
//
//dataHandlingObj.fetchAllRecords()           //Fetch Records
//
//dataHandlingObj.deleteRecord()              //Delete Records
