//
//  PullRequestViewCell.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 15/03/21.
//

import UIKit

public class PullRequestViewCell: UITableViewCell {
    static let cellIdentifier = "PullRequestViewCell"
    
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var dateLabel: UILabel!
    var userView: UserView!
    var bottomSeparator: UIView!
    
    var controller: PullRequestViewCellController?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.controller = PullRequestViewCellController(delegate: self)
        self.selectionStyle = .none
        self.initWidgets()
        self.addViews()
        self.updateViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.updateViews()
    }
    
    public static func registerCell(tableView: UITableView) {
        tableView.register(PullRequestViewCell.self, forCellReuseIdentifier: PullRequestViewCell.cellIdentifier)
    }
    
    private func initWidgets() {
        self.backgroundColor = UIColor.white
        self.titleLabel = UILabel()
        self.titleLabel.textColor = UIColor.titleLabel
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.descriptionLabel = UILabel()
        self.descriptionLabel.numberOfLines = 2
        self.descriptionLabel.textColor = UIColor.githubBlack
        
        self.dateLabel = UILabel()
        self.dateLabel.textAlignment = .right
        self.dateLabel.textColor = UIColor.titleLabel
        self.dateLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        self.userView = UserView(orientation: .BOTTOM)
        
        self.bottomSeparator = UIView()
        self.bottomSeparator.backgroundColor = UIColor.separator
    }
    
    private func addViews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.userView)
        self.addSubview(self.dateLabel)
        self.addSubview(self.bottomSeparator)
    }
    
    private func updateViews() {
        self.titleLabel.frame = CGRect(x: 20, y: 10, width: self.frame.size.width - 30, height: 25)
        self.descriptionLabel.frame = CGRect(x: 20,
                                             y: self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height,
                                             width: self.frame.size.width - 30,
                                             height: 60)
        self.dateLabel.frame = CGRect(x: self.frame.size.width - 100, y: self.frame.size.height - 25, width: 90, height: 20)
        self.userView.frame = CGRect(x: 20,
                                     y: self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height,
                                     width: self.frame.size.width - 30,
                                     height: self.frame.size.height - (self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height))
        
        self.bottomSeparator.frame = CGRect(x: 20, y: self.frame.size.height - 1, width: self.frame.size.width - 110, height: 1)
    }
}

extension PullRequestViewCell {
    func setUp(pullrequest: PullRequestView) {
        self.controller?.setup(pullrequest: pullrequest)
        self.controller?.setData()
    }
}

extension PullRequestViewCell: PullRequestCellDelegate {
    func setDate(date: String) {
        self.dateLabel.text = date
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    func setDescription(description: String) {
        self.descriptionLabel.text = description
    }
    
    func setUser(user: UserViewModel) {
        self.userView.setup(user: user)
    }
}
