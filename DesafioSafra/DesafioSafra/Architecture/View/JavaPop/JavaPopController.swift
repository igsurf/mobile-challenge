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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = Mock().createMockRep()
    }

    @IBAction func showMenu(_ sender: Any) {
        print("show menu")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JavaPopTableViewCell") as? JavaPopTableViewCell else { return JavaPopTableViewCell() }

        guard let item = viewModel?.items?[indexPath.row] else { return cell }
        
        cell.selectionStyle = .none;
        cell.nameRep.text = item.name
        cell.descricao.text = item.description
        cell.fork.text = String(item.forksCount ?? 0)
        cell.star.text = String(item.stargazersCount ?? 0)
        cell.userName.text = item.owner?.login
        cell.nameUser.text = "nome Sobrenome"

        if item.owner?.avatarURL?.path == "" {
            cell.imgContact.image = UIImage.init(named: "contact")
        }else{
            cell.imgContact.sd_setImage(with: item.owner?.avatarURL, placeholderImage: UIImage.init(named: "contact"))
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let viewModel = self.viewModel else {
//            return
//        }
        print("didSelectRowAt: \(indexPath.row)")
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PullRequestViewController") as? PullRequestViewController {

                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        
    }
        
}

