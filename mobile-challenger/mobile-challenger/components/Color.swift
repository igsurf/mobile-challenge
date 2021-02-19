//
//  Color.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import  UIKit

extension UIColor {
        
    static func blueColor() -> UIColor {
        return UIColor(red: CGFloat(84/255.0), green: CGFloat(129/255.0), blue: CGFloat(174/255.0), alpha: CGFloat(1.0))
    }
    
    static func yellowColor() -> UIColor {
        return UIColor( red: CGFloat(213/255.0), green: CGFloat(150/255.0), blue: CGFloat(52/255.0), alpha: CGFloat(1.0) )
    }
    
    static func darkGrayColor() -> UIColor {
        return UIColor( red: CGFloat(52/255.0), green: CGFloat(52/255.0), blue: CGFloat(56/255.0), alpha: CGFloat(1.0) )
    }
    
    static func lightGrayColor() -> UIColor {
        return UIColor( red: CGFloat(170/255.0), green: CGFloat(170/255.0), blue: CGFloat(170/255.0), alpha: CGFloat(1.0) )

    }
}
