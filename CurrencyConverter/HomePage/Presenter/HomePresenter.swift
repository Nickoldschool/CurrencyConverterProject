//
//  HomePagePresenter.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

class HomePresenter: HomeViewOutput {
    
    weak var view: HomeViewInput?
    var interactor: HomeInteractorInput?
    var router: HomeRouterInput?
  
    
}

extension HomePresenter {
    
    func viewready() {
          
          interactor?.loadInfo()
      }
      
      func nextPage() {
          
          router?.closeModule()
      }
      
      func infoLoaded() {
          view?.updateView()
      }
    
}
