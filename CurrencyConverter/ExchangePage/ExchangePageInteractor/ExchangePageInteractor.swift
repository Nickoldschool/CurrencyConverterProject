//
//  ExchangePageInteractor.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 23.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

protocol ExchangePageInteractorInput {
    
}

protocol ExchangePageInteractorOutput: AnyObject {
    
}

final class ExchangePageInteractor {
    
    weak var presenter: ExchangePageInteractorOutput?

}

extension ExchangePageInteractor: ExchangePageInteractorInput{
    
}
