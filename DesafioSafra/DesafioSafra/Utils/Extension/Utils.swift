//
//  Utils.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 30/04/21.
//

import UIKit

class Utils {
    static func createSpinerFooter(width: CGFloat) -> UIView {
        let footeView = UIView(frame: CGRect(x: 0, y: 0, width:width , height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footeView.center
        footeView.addSubview(spinner)
        spinner.startAnimating()
        
        return footeView
    }
}
