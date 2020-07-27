//
//  HomePagePresenter.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

class HomePagePresenter: HomePageViewOutput {
    
    weak var view: HomePageViewInput?
    var interactor: HomePageInteractorInput?
    var router: HomePageRouterInput?
  
    
}

extension HomePagePresenter {
    
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
