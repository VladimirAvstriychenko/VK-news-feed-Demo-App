//
//  GradientView.swift
//  VK news feed
//
//  Created by Владимир on 02.06.2021.
//

import UIKit

class GradientView: UIView {
    
    
    @IBInspectable private var startColor: UIColor?{
        didSet {
            setupGradientColors()
        }
    }
    @IBInspectable private var endColor: UIColor?{
        didSet {
            setupGradientColors()
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds // растягиваем по всем границам
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        
    }
    
    private func setupGradientColors() {
        if let startColor = startColor, let endColor = endColor {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
}
