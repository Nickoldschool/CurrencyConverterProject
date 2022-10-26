//
//  DataManager.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 16.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import CoreData

final class DataManager {

	//MARK: - Shared Instance
	static let shared = DataManager()

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

	//MARK: - Methods

	func entityForName(_ name: String) -> NSEntityDescription {
		return NSEntityDescription.entity(forEntityName: name, in: self.managedObjectContext)!
	}

	// MARK: - CurrencyConvertation CRUD
	func createCurrencyConvertation(model currencyConvertation: CurrencyConvertation) {

		let newCurrencyConvertation = NSEntityDescription.insertNewObject(forEntityName: Keys.currencyConvertation,
																		  into: managedObjectContext) as! CurrencyConvertationEntity

		newCurrencyConvertation.fromCurrency = currencyConvertation.fromCurrency
		newCurrencyConvertation.toCurrency = currencyConvertation.toCurrency
		newCurrencyConvertation.enteredAmount = currencyConvertation.enteredAmount
		newCurrencyConvertation.convertedAmount = currencyConvertation.convertedAmount

		do {
			try managedObjectContext.save()
		} catch {
			print("Failed to create currency: \(error)")
		}
	}

	func retrieveCurrencyConvertation() -> [CurrencyConvertation]? {

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
			print("Failed to get currency: \(error)")
		}
		return nil
	}

	func deleteCurrentCurrencyConvertation(model currencyConvertation: CurrencyConvertation) {
		let fetchRequest: NSFetchRequest<CurrencyConvertationEntity> = CurrencyConvertationEntity.fetchRequest()
		let predicate = NSPredicate(format: "fromCurrency == %@ && toCurrency == %@ && enteredAmount == %f && convertedAmount == %f",                               currencyConvertation.fromCurrency,
									currencyConvertation.toCurrency,
									currencyConvertation.enteredAmount,
									currencyConvertation.convertedAmount)

		fetchRequest.predicate = predicate
		do {
			let currencyConvertation = try managedObjectContext.fetch(fetchRequest)
			for currentConvertation in currencyConvertation {
				managedObjectContext.delete(currentConvertation)

			}
		} catch let err as NSError {
			print("Failed to fetch user", err)
		}

		if managedObjectContext.hasChanges {
			do {
				try managedObjectContext.save()
			} catch let error as NSError {
				print("Error in saving core data: ",
					  error)
			}
		}

	}

	func deleteAllCurrencyConvertation() {
		let fetchRequest: NSFetchRequest<CurrencyConvertationEntity> = CurrencyConvertationEntity.fetchRequest()
		do {
			let currencies = try managedObjectContext.fetch(fetchRequest)
			for currency in currencies {
				managedObjectContext.delete(currency)
			}
		} catch let err as NSError {
			print("Failed to fetch user", err)
		}

		if managedObjectContext.hasChanges {
			do {
				try managedObjectContext.save()
			} catch let error as NSError {
				print("Error in saving core data: ", error)
			}
		}
	}
}
