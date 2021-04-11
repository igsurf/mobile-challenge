//
//  RepositoriesViewController.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import UIKit

protocol RepositoriesViewControllerDelegate: AnyObject {
    func changeCodeLanguage(language: CodeLanguage)
}

enum ServiceType: String {
    case services = "services"
    case mock = "mock"
}

class RepositoriesViewController: BaseViewController {

    // MARK: - Storyboard Outlets

    @IBOutlet var repositoriesTableView: UITableView!
    @IBOutlet var codeLanguageCollectionView: UICollectionView!

    // MARK: - Constants

    private let kCollectionViewIdentifier = "CodeLanguageCell"
    private let tableViewCellIdentifier = "RepositoryCell"
    private let kServiceTypeKey = "Service_type"

    // MARK: - Private Properties

    private var viewModel: RepositoriesListViewModel?
    private var languageCells: [CodeLanguageCell] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupCollectionView()
        setupTableView()
    }

    // MARK: - Private Properties

    private func errorOcurred() {
        let alert = UIAlertController(title: "Erro", message: "ocorreu um erro na api, tente novamente mais tarde", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "ok", style: .cancel)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }

    private func getService() -> ServicesProtocol {
        let serviceType = Bundle.main.object(forInfoDictionaryKey: kServiceTypeKey) as? String
        switch serviceType {
        case ServiceType.mock.rawValue:
            return MockServices()
        case ServiceType.services.rawValue:
            return Services()
        default:
            return Services()
        }
    }

    private func setupCollectionView() {
        let nib = UINib(nibName: kCollectionViewIdentifier, bundle: nil)
        codeLanguageCollectionView.register(nib, forCellWithReuseIdentifier: kCollectionViewIdentifier)
        codeLanguageCollectionView.dataSource = self
        codeLanguageCollectionView.delegate = self
    }

    private func setupTableView() {
        let nib = UINib(nibName: tableViewCellIdentifier, bundle: nil)
        repositoriesTableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
    }

    private func unselectAllLanguageOptions() {
        languageCells.forEach { cell in
            cell.setUnselected()
        }
    }

    private func setupViewModel() {
        viewModel = RepositoriesListViewModel(services: getService())
    }

    private func getRepositoriesList(language: CodeLanguage) {
        showLoading()
        viewModel?.getRepositoriesList(
            language: language,
            success: {
                DispatchQueue.main.async {
                    self.repositoriesTableView.reloadData()
                }
                self.hideLoading()
            }, failure: { _ in
                self.hideLoading()
                self.errorOcurred()
            })
    }

    private func getRepositoriesListNextPage() {
        viewModel?.getRepositoriesListNextPage(success: {
            DispatchQueue.main.async {
                self.repositoriesTableView.reloadData()
            }
        }, failure: { error in
            self.errorOcurred()
        })
    }
}

// MARK: - Tableview Delegate

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.repositoriesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? RepositoryCell, let repository = viewModel?.getRepository(position: indexPath.row)  else { return UITableViewCell() }
        let cellViewModel = RepositoryCellViewModel(model: repository)
        cell.setup(viewModel: cellViewModel)
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            getRepositoriesListNextPage()
        }
    }
}

// MARK: - CollectionView Delegate

extension RepositoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.languageOptions.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewIdentifier, for: indexPath) as? CodeLanguageCell,
              let language = viewModel?.languageOptions[indexPath.row] else { return UICollectionViewCell() }
        languageCells.append(cell)
        let viewModel = CodeLanguageCellViewModel(language: language)
        cell.setup(viewModel: viewModel, controllerDelegate: self)
        return cell
    }
}

// MARK: - Controller Delegate

extension RepositoriesViewController: RepositoriesViewControllerDelegate {
    func changeCodeLanguage(language: CodeLanguage) {
        unselectAllLanguageOptions()
        DispatchQueue.main.async {
            self.viewModel?.resetList()
            self.repositoriesTableView.reloadData()
        }
        getRepositoriesList(language: language)
    }
}
