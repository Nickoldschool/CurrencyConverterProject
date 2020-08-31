//
//  BlurViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 31.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class BlurViewController: UIViewController {
    
    
    //MARK: - Properties
    
    let blurView = UIVisualEffectView()
    let blurEffect = UIBlurEffect(style: .light)
    let whiteView = UIView()
    var textLabel = UILabel()
    let doneButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        
        view.addSubview(blurView)
        view.addSubview(whiteView)
        whiteView.addSubview(textLabel)
        whiteView.addSubview(doneButton)
        
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        //blurView.effect = blurEffect
        
        whiteView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        whiteView.layer.cornerRadius = 15
        whiteView.clipsToBounds = true
        
        textLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = . center
        
        doneButton.setTitle("OK", for: .normal)
        doneButton.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        doneButton.layer.cornerRadius = 15
        doneButton.clipsToBounds = true
        doneButton.addTarget(self, action: #selector(handleDismiss), for: .allEvents)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whiteView.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            whiteView.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            whiteView.widthAnchor.constraint(equalToConstant: 250),
            whiteView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 10),
            textLabel.widthAnchor.constraint(equalToConstant: 200),
            textLabel.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            doneButton.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -10),
            doneButton.widthAnchor.constraint(equalToConstant: 60),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
}
