//
//  UITableView+Extensions.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 10/03/21.
//

import UIKit

extension UITableView {
    
    @objc
    func assignTo(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
    @objc
    func updateSize(size: CGSize) {
        self.frame.size = size
    }
    
    @objc
    func setSeparator(style: UITableViewCell.SeparatorStyle = .singleLine, color: UIColor = UIColor.lightGray) {
        self.separatorStyle = style
        self.separatorColor = color
        self.clipsToBounds = true
    }
}
