//
//  CourcePage.Interactor.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 29.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

protocol CourcePageInteractorInput {

}

protocol CourcePageInteractorOutput: AnyObject {

}

extension CourcePage {

	final class Interactor {

		weak var presenter: CourcePageInteractorOutput?
	}
}

extension CourcePage.Interactor: CourcePageInteractorInput {}
