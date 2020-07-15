//
//  LaunchController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 15.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

class LaunchController: UIViewController {
    
    let label = UILabel()
    var pulseLayers = [CAShapeLayer]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false )
        view.backgroundColor = #colorLiteral(red: 0.9829886556, green: 0.6544682384, blue: 0.4333807528, alpha: 1)
        //view.backgroundColor = #colorLiteral(red: 0.9892832637, green: 0.6514198184, blue: 0.4338295162, alpha: 1)
        createPulse()
        createLabel()

    }
    
    private func createLabel() {
        
        label.backgroundColor = #colorLiteral(red: 0.3421914876, green: 0.02416796796, blue: 0.4802301526, alpha: 1)
        label.text = "Currency Converter"
        label.font = .systemFont(ofSize: 27)
        //label.layer.borderWidth = 1
        //label.layer.borderColor = #colorLiteral(red: 0.3421914876, green: 0.02416796796, blue: 0.4802301526, alpha: 1)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.cornerRadius = 90
        label.layer.masksToBounds = true
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 180),
            label.widthAnchor.constraint(equalToConstant: 180),
        ])
    }
    

    private func createPulse() {
        for _ in 0...2 {
            let circularPath = UIBezierPath(arcCenter: .zero,
                                            radius: UIScreen.main.bounds.size.width/2.4,
                                            startAngle: 0,
                                            endAngle: 2 * .pi, clockwise: true)
            let pulseLayer = CAShapeLayer()
            pulseLayer.path = circularPath.cgPath
            pulseLayer.lineWidth = 55
            pulseLayer.fillColor = UIColor.clear.cgColor
            pulseLayer.lineCap = CAShapeLayerLineCap.round
            pulseLayer.position = view.center
            view.layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.animatePulse(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.animatePulse(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.animatePulse(index: 2)
                }
            }
        }
    }
    
    private func animatePulse(index: Int) {
        pulseLayers[index].strokeColor = #colorLiteral(red: 0.3421914876, green: 0.02416796796, blue: 0.4802301526, alpha: 1)

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 8
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 3.0
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(scaleAnimation, forKey: "scale")
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 8
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(opacityAnimation, forKey: "opacity")
    }

}
