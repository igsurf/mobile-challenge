//
//  RepositoryViewCell.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 13/03/21.
//

import UIKit

public class RepositoryViewCell: UITableViewCell {
    static let cellIdentifier = "RepositoryViewCell"

    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var forksView: CounterView!
    var starView: CounterView!
    var userView: UserView!
    var bottomSeparator: UIView!
    
    var controller: RepositoryViewCellController?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
        
        self.controller = RepositoryViewCellController(delegate: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.updateViews()
    }
    
    
    func setup(repository: RepositoryView) {
        self.controller?.setup(repository: repository)
        self.initWidgets()
        self.addViews()
        self.updateViews()
        self.controller?.setData()
    }

    private func initWidgets() {
        
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.titleLabel.textColor = UIColor.titleLabel
        
        self.descriptionLabel = UILabel()
        self.descriptionLabel.numberOfLines = 2
        self.descriptionLabel.textColor = UIColor.githubBlack
        
        self.forksView = CounterView(type: .FORK)
        
        self.starView = CounterView(type: .STAR)
        
        self.userView = UserView()
        
        self.bottomSeparator = UIView()
        self.bottomSeparator.backgroundColor = UIColor.separator
    }
    
    private func addViews() {
        self.subviews.forEach({view in
            view.removeFromSuperview()
        })
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(forksView)
        self.addSubview(starView)
        self.addSubview(userView)
        self.addSubview(bottomSeparator)
    }
    
    private func updateViews() {
        self.titleLabel.frame = CGRect(x: 20, y: 10, width: self.frame.size.width - 130, height: 25)
        self.descriptionLabel.frame = CGRect(x: 20, y: 35, width: self.frame.size.width - 130, height: 60)
        self.forksView.frame = CGRect(x: 20,
                                      y: self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height,
                                      width: 100,
                                      height: 20)
        self.starView.frame = CGRect(x: self.forksView.frame.origin.x + self.forksView.frame.size.width,
                                     y: self.forksView.frame.origin.y,
                                     width: 100,
                                     height: 20)
        self.userView.frame = CGRect(x: self.frame.width - 110,
                                     y: 0,
                                     width: 100,
                                     height: self.frame.size.height)
        
        self.bottomSeparator.frame = CGRect(x: 20, y: self.frame.size.height - 1, width: self.frame.size.width - 20, height: 1)
        
    }

    public static func registerCell(tableView: UITableView) {
        tableView.register(RepositoryViewCell.self, forCellReuseIdentifier: RepositoryViewCell.cellIdentifier)
    }
}

extension RepositoryViewCell: RepositoryCellDelegate {
    func setUser(user: UserViewModel) {
        self.userView.setup(user: user)
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    func setDescription(description: String) {
        self.descriptionLabel.text = description
    }
    
    func setForksView(forksCount: Int) {
        self.forksView.setup(count: forksCount)
    }
    
    func setStarView(starCount: Int) {
        self.starView.setup(count: starCount)
    }
}
