//
//  CustomControl.swift
//  StarRating
//
//  Created by Craig Swanson on 11/21/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import Foundation
import UIKit

class CustomControl: UIControl {
    
    var value: Int = 1
    var starArray: [UILabel] = []
    
    private let componentDimension: CGFloat = 40.0
    private let componentCount: Int = 5
    private let componentActiveColor: UIColor = .black
    private let componentInactiveColor: UIColor = .lightGray
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        setup()
    }
    
    func setup() {
        starArray = []
        for n in stride(from: CGFloat(1), through: CGFloat(5), by: 1) {
            let newLabel = UILabel(frame: CGRect(x: (n * 8) + (componentDimension * (n - 1)), y: 0, width: componentDimension, height: componentDimension))
            newLabel.tag = Int(n)
            newLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
            newLabel.text = "✩"
            newLabel.textAlignment = .center
            if n <= CGFloat(value) {
                newLabel.textColor = componentActiveColor
            } else {
                newLabel.textColor = componentInactiveColor
            }
            addSubview(newLabel)
            starArray.append(newLabel)
        }
    }
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(at: touch)
        sendActions(for: .touchDown)
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        
        if self.bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: .touchDragOutside)
        }
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer {
            super.endTracking(touch, with: event)
        }
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        
        if self.bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: .touchUpOutside)
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        defer {
            super.cancelTracking(with: event)
        }
        
        sendActions(for: .touchCancel)
    }
    
    private func updateValue(at touch: UITouch) {
        let touchPoint = touch.location(in: self)
        
        for star in starArray {
            if star.frame.contains(touchPoint) {
                if star.tag == value {
                    return
                } else {
                value = star.tag
                setup()
                    star.performFlare()
                sendActions(for: .valueChanged)
                }
            }
        }
    }
}

extension UIView {
    func performFlare() {
      func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
      func unflare() { transform = .identity }
      
      UIView.animate(withDuration: 0.3,
                     animations: { flare() },
                     completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
