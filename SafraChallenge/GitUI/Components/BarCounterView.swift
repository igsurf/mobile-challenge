//
//  BarCounterView.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 15/03/21.
//

import UIKit

public class BarCounterView: UIView {
    var leftLabel: UILabel!
    var centerLabel: UILabel!
    var rightLabel: UILabel!
    var borderBottom: UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initWidgets()
        self.updateView()
        self.addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.updateView()
    }
    
    private func initWidgets() {
        self.backgroundColor = UIColor.white
        
        self.borderBottom = UIView()
        self.borderBottom.backgroundColor = UIColor.separator
        
        self.leftLabel = UILabel()
        self.leftLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.leftLabel.textColor = UIColor.orangeFork
        self.leftLabel.textAlignment = .right
        
        self.centerLabel = UILabel()
        self.centerLabel.text = "|"
        self.centerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.centerLabel.textColor = UIColor.githubBlack
        self.centerLabel.textAlignment = .center
        
        self.rightLabel = UILabel()
        self.rightLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.rightLabel.textColor = UIColor.githubBlack
        self.rightLabel.textAlignment = .left
    }
    
    private func addViews() {
        self.addSubview(self.leftLabel)
        self.addSubview(self.centerLabel)
        self.addSubview(self.rightLabel)
        self.addSubview(self.borderBottom)
    }
    
    private func updateView() {
        self.leftLabel.frame = CGRect(x: 0, y: 0, width: (self.frame.size.width / 2) - 10, height: self.frame.size.height)
        self.centerLabel.frame = CGRect(x: (self.frame.size.width / 2) - 10, y: 0, width: 20, height: self.frame.size.height)
        self.rightLabel.frame = CGRect(x: (self.frame.size.width / 2) + 10, y: 0, width: (self.frame.size.width / 2) - 20, height: self.frame.size.height)
        self.borderBottom.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
    }
}

extension BarCounterView {
    func reloadData() {
        self.updateView()
    }
    
    func setLeft(text: String) {
        self.leftLabel.text = text
    }
    
    func setRight(text: String) {
        self.rightLabel.text = text
    }
}
