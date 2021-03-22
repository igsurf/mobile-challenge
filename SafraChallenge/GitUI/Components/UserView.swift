//
//  UserView.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 13/03/21.
//

import UIKit
import Alamofire
import AlamofireImage

public enum Orientarion: String {
    case BOTTOM
    case TOP
    case LEFT
    case RIGHT
}

public class UserView: UIView {
    var user: UserViewModel?
    var orientation: Orientarion = .RIGHT
    
    var avatar: UIImageView!
    var loginLabel: UILabel!
    var typeLabel: UILabel!
    
    public init(frame: CGRect, orientation: Orientarion = .RIGHT) {
        super.init(frame: frame)
        self.orientation = orientation
        self.callInits()
    }
    
    init(orientation: Orientarion = .RIGHT) {
        super.init(frame: CGRect())
        self.orientation = orientation
        self.callInits()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.updateViews()
    }
    
    private func callInits() {
        self.initWidgets()
        self.addViews()
        self.updateViews()
    }
    
    func setup(user: UserViewModel) {
        self.user = user
        self.setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initWidgets() {
        self.avatar = UIImageView(image: UIImage(named: "user_black", in: Bundle.main, compatibleWith: nil))
        self.avatar.cornerRadius(radius: 20)
        
        self.loginLabel = UILabel()
        self.loginLabel.numberOfLines = 2
        self.loginLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.loginLabel.textColor = UIColor.titleLabel
        
        self.typeLabel = UILabel()
        self.typeLabel.font = UIFont.systemFont(ofSize: 14.0)
        self.typeLabel.textColor = UIColor.githubBlack
    }
    
    private func updateViews() {
        switch self.orientation {
        case .RIGHT:
            self.updateViewsRight()
        case .BOTTOM:
            self.updateViewsBottom()
        default:
            self.updateViewsRight()
        }
    }
    
    private func updateViewsRight() {
        self.avatar.frame = CGRect(x: (self.frame.size.width / 2) - 20, y: 10, width: 40, height: 40)
        self.loginLabel.frame = CGRect(x: 5,
                                       y: self.avatar.frame.origin.y + self.avatar.frame.size.height,
                                       width: self.frame.size.width - 10,
                                       height: 45)
        self.typeLabel.frame = CGRect(x: 5,
                                      y: self.loginLabel.frame.origin.y + self.loginLabel.frame.size.height,
                                      width: self.frame.size.width - 10,
                                      height: 20)
        
        self.typeLabel.textAlignment = .center
        self.loginLabel.textAlignment = .center
    }
    
    private func updateViewsBottom() {
        self.avatar.frame = CGRect(x: 0, y: 10, width: 40, height: 40)
        self.loginLabel.frame = CGRect(x: (self.avatar.frame.origin.x + self.avatar.frame.size.width) + 5,
                                       y: 0,
                                       width: self.frame.size.width - ((self.avatar.frame.origin.x + self.avatar.frame.size.width) + 5),
                                       height: 45)
        self.typeLabel.frame = CGRect(x: self.loginLabel.frame.origin.x,
                                      y: self.loginLabel.frame.origin.y + self.loginLabel.frame.size.height,
                                      width: self.frame.size.width - ((self.avatar.frame.origin.x + self.avatar.frame.size.width) + 5),
                                      height: 20)
        
        self.typeLabel.textAlignment = .left
        self.loginLabel.textAlignment = .left
    }
    
    private func addViews() {
        self.addSubview(self.avatar)
        self.addSubview(self.loginLabel)
        self.addSubview(self.typeLabel)
    }
    
    private func setData() {
        self.loginLabel.text = user?.login
        self.typeLabel.text = user?.type

        if let strUrl = user?.avatar, let url = URL(string: strUrl) {
            self.avatar.af_setImage(withURL: url)
        }
    }
}
