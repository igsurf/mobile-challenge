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

    // MARK: - Private Properties

    private var viewModel: RepositoriesListViewModel?
    private var languageCells: [CodeLanguageCell] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        getRepositoriesList(language: .swift)
        setupCollectionView()
    }

    // MARK: - Private Properties

    private func getService() -> ServicesProtocol {
        let serviceType = Bundle.main.object(forInfoDictionaryKey: "Service_type") as? String
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
            page: 1,
            success: { repositories in
                print(repositories)
                self.hideLoading()
            },
            failure: { error in
                print(error)
                self.hideLoading()
            })
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
        getRepositoriesList(language: language)
    }
}
