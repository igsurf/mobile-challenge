//
//  PullRequestViewController.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 29/04/21.
//

import UIKit

class PullRequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel : PullRequestViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = Mock().createMockPullReques()
        title = "Nome Repositorio"
        
    }
    
}

extension PullRequestViewController: UITableViewDelegate, UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.pullrequest?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PullRequestTableViewCell") as? PullRequestTableViewCell else { return PullRequestTableViewCell() }

        guard let item = viewModel?.pullrequest?[indexPath.row] else { return cell }
        
        cell.selectionStyle = .none;
        cell.lblTitlePull.text = item.title
        cell.lblDescPull.text = item.body
        cell.lblName.text = "Renato"
        cell.lblUserName.text = "rfcbf"
        
//        cell.imgContact.sd_setImage(with: item owner?.avatarURL, placeholderImage: UIImage.init(named: "contact"))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            
            viewController.urlString = viewModel?.pullrequest?[indexPath.row].htmlURL?.absoluteString
            present(viewController, animated: true, completion: nil)

        }
    }
    
}
