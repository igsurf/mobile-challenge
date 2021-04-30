//
//  ViewController.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 26/04/21.
//

import UIKit
import SDWebImage

class JavaPopController: UITableViewController {

    var viewModel : JavaPopViewModel?
    let group = DispatchGroup()
    
    var isFetchInProgress = false
    var nextlink: String = "https://api.github.com/search/repositories?q=language%3AJava&sort=stars"
    
    var userNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = RequestManagerFactory.alamofire.create()
        self.viewModel = JavaPopViewModel(apiRepo: StarsRepositoriesAPI(manager: manager), apiUser: UsersAPI(manager: manager))
        
        self.fetchRepos()
        
    }
    
    private func fetchRepos() {
        if !isFetchInProgress {
            self.tableView.tableFooterView = Utils.createSpinerFooter(width: self.view.frame.width)
            isFetchInProgress = true
            
            if #available(iOS 13.0, *) {
                viewModel?.getRepos(urlString: nextlink, completion: { result, nextlink in
                    
                    switch result {
                    case.success(let itens):
                        for item in itens {
                            self.viewModel?.items.append(item)
                        }
                        
                        self.nextlink = nextlink ?? ""
                        
                        guard let viewModel = self.viewModel else {
                            return
                        }
                        
                        for item in viewModel.items {
                            self.group.enter()
                            guard let username = item.owner?.login else {
                                self.userNames.append("")
                                self.group.leave()
                                return
                            }
                            viewModel.getUser(username: username) { user in
                                self.userNames.append(user?.name ?? "")
                                self.group.leave()
                            }
                        }
                        
                        self.group.notify(queue: .main) {
                            DispatchQueue.main.async {
                                self.isFetchInProgress = false
                                self.tableView.tableFooterView = nil
                                self.tableView.reloadData()
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
    }
    

    @IBAction func showMenu(_ sender: Any) {
        print("show menu")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JavaPopTableViewCell") as? JavaPopTableViewCell else { return JavaPopTableViewCell() }
        
        guard let item = viewModel?.items[indexPath.row] else { return cell }
        
        cell.selectionStyle = .none;
        cell.nameRep.text = item.name
        cell.descricao.text = item.description
        cell.fork.text = String(item.forksCount ?? 0)
        cell.star.text = String(item.stargazersCount ?? 0)
        cell.userName.text = item.owner?.login
        cell.nameUser.text = userNames[indexPath.row]
        

        if item.owner?.avatarURL?.path == "" {
            cell.imgContact.image = UIImage.init(named: "contact")
        }else{
            cell.imgContact.sd_setImage(with: item.owner?.avatarURL, placeholderImage: UIImage.init(named: "contact"))
        }
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt: \(indexPath.row)")
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PullRequestViewController") as? PullRequestViewController {

            guard let item = viewModel?.items[indexPath.row] else { return }
            
            viewController.urlString = item.pullsURL
            viewController.title = item.name
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            if isFetchInProgress {
                return
            }
            fetchRepos()
        }
    }
        
}

