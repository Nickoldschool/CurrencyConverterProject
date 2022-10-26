//
//  CourcePage.Cell.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 31.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

extension CourcePage {

	final class Cell: UICollectionViewCell {

		static let identifier = "CourcePageCell"
		let flagImage = UIImageView(image: UIImage(named: ""))
		let currencyName = UILabel()
		let currencyRate = UILabel()
		let resulLabel = UILabel()

		override init(frame: CGRect) {
			super.init(frame: frame)

			addSubViews()
			setUpConstraints()
		}

		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		private func addSubViews() {

			style(view: contentView)
			contentView.addSubview(flagImage)
			contentView.addSubview(currencyName)
			contentView.addSubview(currencyRate)
			contentView.addSubview(resulLabel)
		}

		private func setUpConstraints() {

			flagImage.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				flagImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
				flagImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
				flagImage.heightAnchor.constraint(equalToConstant: 35),
				flagImage.widthAnchor.constraint(equalToConstant: 35),
			])

			currencyName.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				currencyName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
				currencyName.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
				currencyName.leftAnchor.constraint(equalTo: flagImage.rightAnchor, constant: 15),
				currencyName.rightAnchor.constraint(equalTo: contentView.centerXAnchor),
			])

			currencyRate.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				currencyRate.topAnchor.constraint(equalTo: contentView.centerYAnchor),
				currencyRate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
				currencyRate.leftAnchor.constraint(equalTo: flagImage.rightAnchor, constant: 15),
				currencyRate.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -100),
			])

			resulLabel.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				resulLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 9),
				resulLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
				resulLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
				resulLabel.leftAnchor.constraint(equalTo: currencyRate.rightAnchor, constant: 5),
			])
		}

		fileprivate func style(view: UIView) {
			view.layer.masksToBounds        = false
			view.backgroundColor            = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
			view.layer.cornerRadius         = 5
			view.layer.shadowColor          = UIColor.black.cgColor
			view.layer.shadowOffset         = CGSize(width: 1, height: 5)
			view.layer.shadowRadius         = 8
			view.layer.shadowOpacity        = 0.3
			view.layer.shadowPath           = UIBezierPath(roundedRect: view.bounds,
														   byRoundingCorners: .allCorners,
														   cornerRadii: CGSize(width: 14, height: 14)).cgPath
			view.layer.shouldRasterize      = true
			view.layer.rasterizationScale   = UIScreen.main.scale

			flagImage.contentMode           = .scaleAspectFit

			currencyName.textColor          = .white
			currencyRate.textColor          = .white
			resulLabel.textColor            = .white

		}

		public func updateData(rate: Rate, entery: Double) {

			if entery == 0 {
				currencyName.text               = rate.currency
				currencyRate.text               = "Current rate: \(String(round((rate.rate)*100)/100))"
				flagImage.image                 = UIImage(named: rate.currency)
				resulLabel.text = ""
			} else {
				currencyName.text               = rate.currency
				currencyRate.text               = "Current rate: \(String(round((rate.rate)*100)/100))"
				flagImage.image                 = UIImage(named: rate.currency)
				resulLabel.text = String(round((entery * rate.rate)*100)/100)
			}
		}
	}
}
