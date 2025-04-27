//
//  CirclesView.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 03.03.2025.
//

import UIKit

class CirclesView: UIView {
    
    private var colors: [(color: UIColor, percentage: CGFloat)] = []
    
    func configure(with colors: [(color: UIColor, percentage: CGFloat)]) {
        self.colors = colors
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.removeAll()

        let baseSize: CGFloat = 100
        let sizeMultiplier: CGFloat = 2.5
        let maxSize = min(bounds.width, bounds.height) * 0.9
        let centerX = bounds.midX
        let centerY = bounds.midY

        let sortedColors = colors.sorted { $0.percentage > $1.percentage }

        for (index, colorInfo) in sortedColors.enumerated() {
            var size = baseSize * sizeMultiplier * colorInfo.percentage * 2
            let minSize: CGFloat = 20
            size = max(min(size, maxSize), minSize)

            var xOffset: CGFloat = 0
            var yOffset: CGFloat = 0
            
            if index > 0 {
                let spacingMultiplier = size / baseSize
                xOffset = index % 2 == 0 ? -size * spacingMultiplier * 0.35 : size * spacingMultiplier * 0.35
                yOffset = CGFloat(Float(index) / 2.25) * size * 0.85 / (colorInfo.percentage * 10 / 9.5)
            }

            var circleX = centerX - size / 2 + xOffset
            var circleY = centerY - size / 2.75 + yOffset
            
            circleX = max(0, min(circleX, bounds.width - size))
            circleY = max(0, min(circleY, bounds.height - size * 1.25))

            let circleRect = CGRect(x: circleX, y: circleY, width: size, height: size)

            let circleLayer = CAShapeLayer()
            circleLayer.path = UIBezierPath(ovalIn: circleRect).cgPath
            circleLayer.fillColor = colorInfo.color.cgColor
            layer.insertSublayer(circleLayer, at: 0)

            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = circleRect
            gradientLayer.colors = [
                colorInfo.color.withAlphaComponent(1.0).cgColor,
                colorInfo.color.withAlphaComponent(0.0).cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.cornerRadius = size / 2

            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(ovalIn: circleRect).cgPath
            gradientLayer.mask = maskLayer

            layer.insertSublayer(gradientLayer, above: circleLayer)

            let percentageLabel = CATextLayer()
            percentageLabel.string = "\(Int(colorInfo.percentage * 100))%"
            percentageLabel.font = UIFont(name: "VelaSansGX-ExtraLight_Regular", size: 20)
            percentageLabel.fontSize = size * 0.15
            percentageLabel.alignmentMode = .center
            percentageLabel.foregroundColor = UIColor.black.cgColor
            percentageLabel.frame = CGRect(
                x: circleRect.midX - size * 0.15,
                y: circleRect.midY - size * 0.1,
                width: size * 0.4,
                height: size * 0.2
            )
            percentageLabel.contentsScale = UIScreen.main.scale

            layer.insertSublayer(percentageLabel, above: gradientLayer)
        }
    }
}
