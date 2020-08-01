//
//  HomePageInteractor.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

protocol HomeInteractorInput {
    func loadInfo()
}

protocol HomeInteractorOutput: AnyObject {
    func infoLoaded()
}

class HomeInteractor: NSObject {
    
    weak var presenter: HomeInteractorOutput?
    
    func loadInfo() {
           presenter?.infoLoaded()
       }

}
