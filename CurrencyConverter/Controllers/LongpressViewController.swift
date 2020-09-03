//
//  LongpressViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 01.09.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class LongpressViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let button = UIButton()
        
        button.backgroundColor = .red
        button.layer.cornerRadius = 35
        button.setTitle("X", for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 70),
            button.widthAnchor.constraint(equalToConstant: 70),
        ])
        
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)

    }

    
    @objc private func handleDismiss() {
           dismiss(animated: true, completion: nil)
       }

}
