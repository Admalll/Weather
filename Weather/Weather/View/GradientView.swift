//
//  GradientView.swift
//  Weather
//
//  Created by Vlad on 05.08.2021.
//

import UIKit

@IBDesignable class GradientView: UIView {

    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    var gradientLayer: CAGradientLayer {
        guard let layer = layer as? CAGradientLayer else { return CAGradientLayer() }
        return layer
    }

    @IBInspectable var startColor: UIColor = .white {
        didSet {
            updateColors()
        }
    }

    @IBInspectable var endColor: UIColor = .black {
        didSet {
            updateColors()
        }
    }

    @IBInspectable var startLocaction: CGFloat = 0 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable var endLocation: CGFloat = 1 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable var startPoint: CGPoint = .zero {
        didSet {
            updateStartPoint()
        }
    }

    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            updateEndPoint()
        }
    }

    func updateLocations() {
        gradientLayer.locations = [startLocaction as NSNumber, endLocation as NSNumber]
    }

    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }

    func updateStartPoint() {
        gradientLayer.startPoint = startPoint
    }

    func updateEndPoint() {
        gradientLayer.endPoint = endPoint
    }

}
