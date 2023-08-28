//
//  UIViewController+GradientBackground.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

extension UIViewController {
    func addGradientBackground(topColor: UIColor = Constants.Colors.blueFlag.color,
                               bottomColor: UIColor = Constants.Colors.yellowFlag.color) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func addGradientBackgroundWithAnimation(topColor: UIColor = Constants.Colors.blueFlag.color,
                                            bottomColor: UIColor = Constants.Colors.yellowFlag.color) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)

        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [topColor.cgColor, bottomColor.cgColor]
        animation.toValue = [bottomColor.cgColor, topColor.cgColor]
        animation.duration = 10.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "colorAnimation")
    }
}
