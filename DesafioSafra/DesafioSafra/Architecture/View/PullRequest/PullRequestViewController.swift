//
//  PullRequestViewController.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 29/04/21.
//

import UIKit

class PullRequestViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblOpened: UILabel!
    @IBOutlet weak var lblClosed: UILabel!
    
    var urlString: String?
    var viewModel : PullRequestViewModel?
    let group = DispatchGroup()
    var userNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Nome Repositorio"
        self.lblOpened.text = "0 opened"
        self.lblClosed.text = "0 closed"

        let manager = RequestManagerFactory.alamofire.create()
        viewModel = PullRequestViewModel(apiPullrequest: PullsApi(manager: manager), apiUser: UsersAPI(manager: manager))
        
        fetchPulls()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.tableFooterView = Utils.createSpinerFooter(width: self.view.frame.width)
    }
    
    private func fetchPulls() {
        if let urlString = urlString {
            viewModel?.getPulls(urlString: urlString, completion: { result in
                
                switch result {
                case.success(let pulls):
                    self.viewModel?.pullrequest = pulls

                    self.countClosed()
                    
                    guard let viewModel = self.viewModel else {
                        return
                    }
                    
                    for pull in viewModel.pullrequest {
                        self.group.enter()
                        guard pull.user != nil else {
                            self.userNames.append("")
                            self.group.leave()
                            return
                        }
                        viewModel.getUser(username: pull.user?.login ?? "") { user in
                            self.userNames.append(user?.name ?? "")
                            self.group.leave()
                        }
                    }
                    
                    self.group.notify(queue: .main) {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.tableView.tableFooterView = nil
                        }
                        
                    }
                    
                case.failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                
            })
        }
    }
    
    func countClosed() {
        
        var opened : Int = 0
        var closed : Int = 0
        
        guard let viewmodel = self.viewModel?.pullrequest else {
            self.lblOpened.text = "\(opened) opened"
            self.lblClosed.text = "\(closed) closed"
            return
        }
        
        for item in viewmodel {
            
            if item.locked! {
                closed += 1
            }else{
                opened += 1
            }
            
        }
        
        self.lblOpened.text = "\(opened) opened"
        self.lblClosed.text = "\(closed) closed"
        
    }
    
}



extension PullRequestViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.pullrequest.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PullRequestTableViewCell") as? PullRequestTableViewCell else { return PullRequestTableViewCell() }
        
        guard let item = viewModel?.pullrequest[indexPath.row] else { return cell }
        
        cell.selectionStyle = .none;
        cell.lblTitlePull.text = item.title
        cell.lblDescPull.text = item.body
        cell.lblName.text = item.user?.login
        cell.lblUserName.text =  userNames[indexPath.row]
        
        cell.imgUser.sd_setImage(with: item.user?.avatarURL, placeholderImage: UIImage.init(named: "contact"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            
            viewController.urlString = viewModel?.pullrequest[indexPath.row].htmlURL?.absoluteString
            present(viewController, animated: true, completion: nil)
            
        }
    }
    
    
}
