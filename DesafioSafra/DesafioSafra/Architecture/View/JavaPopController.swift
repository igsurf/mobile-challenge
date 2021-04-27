//
//  ViewController.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 26/04/21.
//

import UIKit

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
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JavaPopTableViewCell") as? JavaPopTableViewCell else { return JavaPopTableViewCell() }
        
        cell.selectionStyle = .none;
        cell.nameRep.text = viewModel?.items?[indexPath.row].name
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    }
    
}

