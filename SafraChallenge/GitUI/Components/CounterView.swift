//
//  CounterView.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 13/03/21.
//

import UIKit

public enum CounterType: String {
    case FORK = "code_fork"
    case STAR = "star"
}

public class CounterView: UIView {
    
    var icon: UIImageView!
    var countLabel: UILabel!
    var type: CounterType = .FORK
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initWidgets()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.updateViews()
    }
    
    public init(frame: CGRect, type: CounterType) {
        super.init(frame: frame)
        self.type = type
        self.initWidgets()
    }
    
    public init(type: CounterType) {
        super.init(frame: CGRect())
        self.type = type
        self.initWidgets()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initWidgets()
    }
    
    private func initWidgets() {
        self.icon = UIImageView()
        self.icon.image = UIImage(named: type.rawValue, in: Bundle.main, compatibleWith: nil)
        self.icon.tintColor = UIColor.orangeFork
        self.countLabel = UILabel()
        self.countLabel.textColor = UIColor.orangeFork
        self.countLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        self.addSubview(self.icon)
        self.addSubview(self.countLabel)
    }
    
    private func updateViews() {
        self.icon.frame = CGRect(x: 0, y: 0, width: 20, height: self.frame.size.height)
        self.countLabel.frame = CGRect(x: 20,
                                       y: 0,
                                       width: self.frame.size.width - 20,
                                       height: self.frame.size.height)
    }
    
    func setup(count: Int) {
        self.countLabel.text = String(describing: count)
    }
}
