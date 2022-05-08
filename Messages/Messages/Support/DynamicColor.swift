//
//  DynamicColor.swift
//  Messages
//
//  Created by Denis on 07.05.2022.
//

import Foundation
import UIKit

@objc open class DynamicColor: NSObject {
    
    var light: UIColor
    var dark: UIColor
    
    init(light: UIColor, dark: UIColor) {
        self.light = light
        self.dark = dark
    }
}

extension DynamicColor {
    
    func resolve() -> UIColor {
        return UIColor.DynamicResolved(color: self)
    }
}

extension UIColor {
    
    class func DynamicResolved(color: DynamicColor) -> UIColor {
        let dynamicColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return color.dark
            } else {
                return color.light
            }
        }
        
        return dynamicColor
    }
}

