//  GradientView.swift

import UIKit

class GradientView: UIView {
    
    @IBInspectable private var firstColor: UIColor? {
        didSet {
            setupGradientColors()
        }
    }
    @IBInspectable private var secondColor: UIColor? {
        didSet {
            setupGradientColors()
        }
    }
    
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        setupGradientColors()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    private func setupGradientColors() {
        if let firstColor = self.firstColor, let secondColor = self.secondColor {
            gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        }
    }
}
