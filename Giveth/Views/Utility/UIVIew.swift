//
//  UIVIew.swift
//  Giveth
//
//  Created by Jack on 28/06/22.
//

import Foundation

import UIKit

@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    func pulse(withIntensity intensity: CGFloat, withDuration duration: Double, loop: Bool) {
        UIView.animate(withDuration: duration, delay: 0, options: [.autoreverse], animations: {
                //loop ? nil : UIView.setAnimationRepeatCount(1)
                self.transform = CGAffineTransform(scaleX: intensity, y: intensity)
            }) { (true) in
                self.transform = CGAffineTransform.identity
            }
        }
}
