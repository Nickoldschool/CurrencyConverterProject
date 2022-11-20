//
//  PulsatingLayer.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.11.2022.
//  Copyright © 2022 Nick Chekmazov. All rights reserved.
//

import UIKit

/// Слой CAShapeLayer с пульсирующей анимацией.
final class PulsatingLayer: CAShapeLayer {

	// MARK: - Overrides

	override var strokeColor: CGColor? {
		get { strokeLayerStrokeColor }
		set { strokeLayerStrokeColor = newValue }
	}

	override var fillColor: CGColor? {
		get { strokeLayerFillColor }
		set { strokeLayerFillColor = newValue }
	}


	override var lineWidth: CGFloat {
		get { lineWidthLayer }
		set { lineWidthLayer = newValue }
	}

	override var lineCap: CAShapeLayerLineCap {
		get { lineCapLayer }
		set { lineCapLayer = newValue }
	}

	override var path: CGPath? {
		get { circularLayerPath }
		set { circularLayerPath = newValue }
	}

	// MARK: - Private properties

	private struct Constants {
		static let radius: CGFloat = 90
		static let multiplier: CGFloat = 2
		static let layerLineWidth: CGFloat = 20
		static let animationFromValue: CGFloat = 1.0
		static let animationToValue: CGFloat = 1.1
		static let animationDuration: CFTimeInterval = 1.2
	}

	private var strokeLayerStrokeColor: CGColor? = #colorLiteral(red: 0.6424693465, green: 0.002870330121, blue: 0.9131718278, alpha: 1)
	private var strokeLayerFillColor: CGColor? = #colorLiteral(red: 0.8907467723, green: 0.3703051805, blue: 0.9049718976, alpha: 1)
	private var lineWidthLayer: CGFloat = Constants.layerLineWidth
	private var lineCapLayer: CAShapeLayerLineCap = .round

	private lazy var circularLayerPath: CGPath? = {
		let beitherPath =  UIBezierPath(arcCenter: .zero,
										radius: Constants.radius,
										startAngle: -.pi / Constants.multiplier,
										endAngle: Constants.multiplier * .pi,
										clockwise: true)
		return beitherPath.cgPath
	}()

	private let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

	private lazy var animationLayer: CABasicAnimation = {
		let animation = CABasicAnimation(keyPath: "transform.scale")
		animation.fromValue = Constants.animationFromValue
		animation.toValue = Constants.animationToValue
		animation.duration = Constants.animationDuration
		animation.timingFunction = timingFunction
		animation.autoreverses = true
		animation.repeatCount = .infinity
		return animation
	}()

	// MARK: - Initializations

	/// Инициализатор для создания анимированного слоя.
	/// - Parameter point: Точка, относительно которой будет отображаться слой с анимацией.
	init(with point: CGPoint) {
		super.init()

		addPosition(with: point)
		addPulseAnimation()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Private methods

private extension PulsatingLayer {

	func addPosition(with point: CGPoint) {
		self.position = point
	}

	func addPulseAnimation() {
		self.add(animationLayer, forKey: "pulsating")
	}
}
