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

    func addCurrencyRecordIntoCoreData(base: String, date: String, rates: String){
        //1 create appdelegate Singleton object
        guard  let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2.Access persistentContainer from appdelegate Singleton object and Access the singleton managed object context
        let viewContext = appdelegate.persistentContainer.viewContext
        
        //3. Create an entity
        
        if let currenciesEntity = NSEntityDescription.entity(forEntityName: "Currencies", in: viewContext){
            //4. Create managed object
            let currency = NSManagedObject(entity: currenciesEntity, insertInto: viewContext)
            currency.setValue(base, forKey: "base")
            currency.setValue(date, forKey: "date")
            currency.setValue(rates, forKey: "rates")
            
        }
        
       //5. Save to persistent store
        if viewContext.hasChanges{
            do{
                try viewContext.save()
                print("Save \(base)")
                print("Save \(date)")
                print("Save \(rates)")
            }catch let error as NSError{
                print("not Save==\(error),\(error.userInfo)")
            }
        }
        
    }
    
    func fetchAllRecords(){
        //1 create appdelegate Singleton object
        guard  let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2.Access persistentContainer from appdelegate Singleton object and Access the singleton managed object context
        let viewContext = appdelegate.persistentContainer.viewContext
        
        //3. Creating fetch request using this we can only filter NSManagedObject having entity name Car.
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Currencies")
        
        do{
            //4. Execute request
            let currencies = try viewContext.fetch(fetchRequest)
            for (index,currency) in currencies.enumerated(){
            //5. Access Data
                print("\(index). \(currency.value(forKey: "rates") ?? "No Name Available")")
            }
        } catch let error as NSError{
            print("not fetch==\(error),\(error.userInfo)")
        }
    }
    
    func deleteRecord(){
        //1 create appdelegate Singleton object
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        
        //2.Access persistentContainer from appdelegate Singleton object and Access the singleton managed object context
        let viewContext = appDelegate.persistentContainer.viewContext
        
        //3. Creating fetch request using this we can only filter NSManagedObject having entity name Car.
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Currencies")
        
        do{
            //4. Access Revords
            let currencies = try viewContext.fetch(fetchRequest)
            
            for currency in currencies{
            //5. Delete Record
                viewContext.delete(currency)
                print("Deleted \(currency.value(forKey: "rate") ?? "No Name Available")")
            }
        } catch let error as NSError{
            print("not deleted==\(error),\(error.userInfo)")
        }
        
        if viewContext.hasChanges{
            do{
                //6. Commit changes
                try viewContext.save()
            }catch let error as NSError{
                print("not save==\(error),\(error.userInfo)")
            }
        }
        
    }
}

//MARK: - USAGE
//
//let testHandlingObj = TestHandling()
//
//
//testHandlingObj.addCurrencyRecordIntoCoreData(base: "EUR",                    //Records Added
//                                              date: "2020-08-04",
//                                              rates: "Nickoldschool")
//
//
//testHandlingObj.fetchAllRecords()           //Fetch Records
//
//
//testHandlingObj.deleteRecord()              //Delete Records
