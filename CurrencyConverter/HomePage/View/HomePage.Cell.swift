//
//  HomePage.Cell.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 11.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

extension HomePage {

	final class Cell: UICollectionViewCell, UIGestureRecognizerDelegate {

		var pan: UIPanGestureRecognizer!
		var deleteLabel: UILabel!

		static let identifier = "HomePageCell"

		var firstLabel  = UILabel()
		var secondLabel = UILabel()
		var thirdlabel  = UILabel()
		var fourthLabel = UILabel()
		let equalLabel  = UILabel()

		override init(frame: CGRect) {
			super.init(frame: frame)

			addSubViews()
			setUpConstraints()
		}

		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		private func addSubViews() {

			style()
			contentView.addSubview(firstLabel)
			contentView.addSubview(secondLabel)
			contentView.addSubview(thirdlabel)
			contentView.addSubview(fourthLabel)
			contentView.addSubview(equalLabel)
		}

		private func setUpConstraints() {

			[firstLabel, secondLabel, equalLabel, thirdlabel, fourthLabel ].forEach {
				$0.translatesAutoresizingMaskIntoConstraints = false
			}

			NSLayoutConstraint.activate([
				firstLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
				firstLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
				firstLabel.heightAnchor.constraint(equalToConstant: 35),
				firstLabel.widthAnchor.constraint(equalToConstant: 80),

				secondLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
				secondLabel.leadingAnchor.constraint(equalTo: firstLabel.trailingAnchor, constant: 10),
				secondLabel.heightAnchor.constraint(equalToConstant: 35),
				secondLabel.widthAnchor.constraint(equalToConstant: 50),

				equalLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
				equalLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
				equalLabel.heightAnchor.constraint(equalToConstant: 35),
				equalLabel.widthAnchor.constraint(equalToConstant: 50),

				thirdlabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
				thirdlabel.trailingAnchor.constraint(equalTo: fourthLabel.leadingAnchor, constant: -10),
				thirdlabel.heightAnchor.constraint(equalToConstant: 35),
				thirdlabel.widthAnchor.constraint(equalToConstant: 80),

				fourthLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
				fourthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
				fourthLabel.heightAnchor.constraint(equalToConstant: 35),
				fourthLabel.widthAnchor.constraint(equalToConstant: 50),
			])
		}

		fileprivate func style() {
			contentView.layer.masksToBounds        = false
			contentView.backgroundColor            = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
			contentView.layer.cornerRadius         = 5
			contentView.layer.shadowColor          = UIColor.black.cgColor
			contentView.layer.shadowOffset         = CGSize(width: 1, height: 5)
			contentView.layer.shadowRadius         = 8
			contentView.layer.shadowOpacity        = 0.3
			contentView.layer.shadowPath           = UIBezierPath(roundedRect: contentView.bounds,
																  byRoundingCorners: .allCorners,
																  cornerRadii: CGSize(width: 14, height: 14)).cgPath
			contentView.layer.shouldRasterize      = true
			contentView.layer.rasterizationScale   = UIScreen.main.scale

			firstLabel.textColor            = .white
			secondLabel.textColor           = .white
			thirdlabel.textColor            = .white
			fourthLabel.textColor           = .white

			firstLabel.textAlignment        = .right
			thirdlabel.textAlignment        = .right

			equalLabel.text                 = " = "
			equalLabel.textAlignment        = .center
			equalLabel.textColor            = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

			deleteLabel                     = UILabel()
			deleteLabel.text                = " Delete "
			deleteLabel.textAlignment       = .left
			deleteLabel.textColor           = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			deleteLabel.backgroundColor     = #colorLiteral(red: 1, green: 0, blue: 0.1665322185, alpha: 1)
			insertSubview(deleteLabel, belowSubview: contentView)

			pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
			pan.delegate = self
			addGestureRecognizer(pan)

		}

		override func layoutSubviews() {
			super.layoutSubviews()

			let p: CGPoint = pan.translation(in: self)
			let width = self.contentView.frame.width
			let height = self.contentView.frame.height

			if (pan.state == UIGestureRecognizer.State.changed) {
				contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
				deleteLabel.frame = CGRect(x: p.x + width + deleteLabel.frame.size.width, y: 0,
										   width: -width, height: height)
			}
		}

		@objc func onPan(_ pan: UIPanGestureRecognizer) {
			if pan.state == UIGestureRecognizer.State.began {

			} else if pan.state == UIGestureRecognizer.State.changed {
				self.setNeedsLayout()
			} else {
				if abs(pan.velocity(in: self).x) > 300 {
					let collectionView: UICollectionView = self.superview as! UICollectionView
					let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
					collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)),
															 forItemAt: indexPath, withSender: nil)
				} else {
					UIView.animate(withDuration: 0.2, animations: {
						self.setNeedsLayout()
						self.layoutIfNeeded()
					})
				}
			}
		}

		func updateData(currencyConvertation: CurrencyConvertation) {
			firstLabel.text = String(currencyConvertation.enteredAmount)
			secondLabel.text = currencyConvertation.fromCurrency
			thirdlabel.text = String(currencyConvertation.convertedAmount)
			fourthLabel.text = currencyConvertation.toCurrency
		}
	}
}
