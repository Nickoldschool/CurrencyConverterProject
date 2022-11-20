//
//  HomePage.ViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 15.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

protocol HomePageViewInput: AnyObject {

	func updateView()
}

protocol HomePageViewOutput {

	func viewready()

	func nextPage()
}

protocol PassData: AnyObject {

	// Try to convert it into function with these parametres for futher comfortable delegation
	var currencyConvertation: [ExchangePage.Entity.CurrencyConvertation] {get set}
}

extension HomePage {

	final class ViewController: UIViewController, HomePageViewInput, PassData, UIGestureRecognizerDelegate {

		var presenter: HomePageViewOutput?

		let locationLabel = UILabel()
		let button = UIButton()
		let infoLabel = UILabel()
		let recentConvertationsLabel = UILabel()

		//MARK: - Collection elements
		let layout = UICollectionViewFlowLayout()

		let homeCollectionView: UICollectionView = {
			let layout = UICollectionViewFlowLayout()
			layout.scrollDirection = .vertical
			let tempCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
			return tempCV
		}()

		var currencyConvertation = [ExchangePage.Entity.CurrencyConvertation]()
		var currencies = DataManager.shared.retrieveCurrencyConvertation()

		private var pulsatingLayer: PulsatingLayer?

		override func viewDidLoad() {
			super.viewDidLoad()

			view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			navigationController?.setNavigationBarHidden(true, animated: false)

			setupCurrentLocation()
			let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
			longPressRecognizer.minimumPressDuration = 0.5
			longPressRecognizer.delaysTouchesBegan = true
			longPressRecognizer.delegate = self
			self.view.addGestureRecognizer(longPressRecognizer)
		}

		@objc
		func longPressed(sender: UILongPressGestureRecognizer) {

			let longPressVC = LongpressViewController()
			longPressVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
			present(longPressVC, animated: true, completion: nil)

			DataManager.shared.deleteAllCurrencyConvertation()
			currencies = DataManager.shared.retrieveCurrencyConvertation()
			homeCollectionView.reloadData()

			configureEmptyScreenMode()
			button.isHidden = false
			infoLabel.isHidden = false
			recentConvertationsLabel.isHidden = true
		}

		override func viewWillAppear(_ animated: Bool) {
			super.viewWillAppear(animated)

			currencies = DataManager.shared.retrieveCurrencyConvertation()
			checkValidScreenState()
		}

		private func checkValidScreenState() {
			if currencies!.isEmpty {
				configureEmptyScreenMode()
				button.isHidden = false
				infoLabel.isHidden = false
				recentConvertationsLabel.isHidden = true
			} else {
				configureFilledScreenMode()
				button.isHidden = true
				infoLabel.isHidden = true
				recentConvertationsLabel.isHidden = false
				homeCollectionView.reloadData()
			}
		}

		//MARK: - Configure Elements
		private func configureEmptyScreenMode() {

			infoLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			infoLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			infoLabel.text = "No current convertations,go to Exchange to convert"
			infoLabel.textAlignment = .center
			infoLabel.numberOfLines = 0

			button.layer.cornerRadius = 90
			button.layer.masksToBounds = true
			button.setTitleColor( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal )
			button.setTitle("Choose currency", for: .normal)
			button.titleLabel?.font = UIFont(name: "Times New Roman", size:27)
			button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
			button.titleLabel?.textAlignment = .center
			button.backgroundColor = #colorLiteral(red: 0.3949316144, green: 0.02323797345, blue: 0.5600934625, alpha: 1)
			button.addTarget(self, action: #selector(moveToExchangeController), for: .touchUpInside)

			pulsatingLayer = PulsatingLayer(with: view.center)
			if let pulsatingLayer = pulsatingLayer {
				view.layer.addSublayer(pulsatingLayer)
			}

			[button, infoLabel].forEach {
				$0.translatesAutoresizingMaskIntoConstraints = false
				view.addSubview($0)
			}

			NSLayoutConstraint.activate([
				button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
				button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				button.heightAnchor.constraint(equalToConstant: 180),
				button.widthAnchor.constraint(equalToConstant: 180),

				infoLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50),
				infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				infoLabel.heightAnchor.constraint(equalToConstant: 90),
				infoLabel.widthAnchor.constraint(equalToConstant: 250),
			])
		}

		//MARK: - CollectionView
		private func configureFilledScreenMode() {

			pulsatingLayer?.removeAllAnimations()
			pulsatingLayer?.removeFromSuperlayer()

			recentConvertationsLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			recentConvertationsLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			recentConvertationsLabel.text = "Recent convertations:"
			recentConvertationsLabel.textAlignment = .center
			recentConvertationsLabel.numberOfLines = 0

			layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
			layout.itemSize = CGSize(width: view.frame.width - 40, height: 45)
			homeCollectionView.delegate   = self
			homeCollectionView.dataSource = self
			homeCollectionView.register(HomePage.Cell.self, forCellWithReuseIdentifier: HomePage.Cell.identifier)
			homeCollectionView.backgroundColor = .white

			[recentConvertationsLabel, homeCollectionView].forEach {
				$0.translatesAutoresizingMaskIntoConstraints = false
				view.addSubview($0)
			}
			NSLayoutConstraint.activate([
				recentConvertationsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
				recentConvertationsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				recentConvertationsLabel.heightAnchor.constraint(equalToConstant: 35),
				recentConvertationsLabel.widthAnchor.constraint(equalToConstant: 250),

				homeCollectionView.topAnchor.constraint(equalTo: recentConvertationsLabel.bottomAnchor, constant: 10),
				homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
				homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
				homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
			])
		}

		//MARK: - Setup current Location
		private func setupCurrentLocation() {

			locationLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			locationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			locationLabel.textAlignment = .center
			locationLabel.numberOfLines = 0
			locationLabel.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(locationLabel)
			NSLayoutConstraint.activate([
				locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
				locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				locationLabel.heightAnchor.constraint(equalToConstant: 90),
				locationLabel.widthAnchor.constraint(equalToConstant: 250),
			])
		}

		//MARK: - Call button for moving to next view
		@objc
		private func moveToExchangeController() {

			presenter?.nextPage()
			let blurView = BlurViewController()
			blurView.textLabel.text = "Please, go to Exchange page for convertation"
			blurView.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
			present(blurView, animated: true, completion: nil)
		}

		func updateView() {}
	}
}

//MARK: - UICollectionViewDelegate
extension HomePage.ViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		guard let currencyConv = currencies?[indexPath.row] else { return UICollectionViewCell() }
		guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomePage.Cell.identifier, for: indexPath) as? HomePage.Cell else { return UICollectionViewCell() }
		cell.updateData(currencyConvertation: currencyConv)
		return cell
	}
}

//MARK: - UICollectionViewDataSource
extension HomePage.ViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let newCurrencies = currencies else { return  0 }
		if newCurrencies.isEmpty {
			return 0
		} else {
			return newCurrencies.count
		}
	}

	func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
		DataManager.shared.deleteCurrentCurrencyConvertation(model: currencies![indexPath.row])
		currencies!.remove(at: indexPath.row)
		collectionView.deleteItems(at: [indexPath])
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomePage.ViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return layout.itemSize
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 20
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return layout.sectionInset
	}
}
