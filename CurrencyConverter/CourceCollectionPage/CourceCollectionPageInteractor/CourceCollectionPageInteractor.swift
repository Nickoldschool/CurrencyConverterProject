//
//  CourceTabPageInteractor.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 29.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

protocol CourceCollectionPageInteractorInput {
    
}

protocol CourceCollectionPageInteractorOutput: AnyObject {
    
}

final class CourceCollectionPageInteractor {
    
    weak var presenter: CourceCollectionPageInteractorOutput?

}

extension CourceCollectionPageInteractor: CourceCollectionPageInteractorInput {
    
}
