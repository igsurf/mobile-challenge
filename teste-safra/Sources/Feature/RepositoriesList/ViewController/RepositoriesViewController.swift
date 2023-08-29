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
    case services
    case mock
}

class RepositoriesViewController: BaseViewController {

    // MARK: - Storyboard Outlets

    @IBOutlet var repositoriesTableView: UITableView!
    @IBOutlet var codeLanguageCollectionView: UICollectionView!

    // MARK: - Constants

    private let kCollectionViewIdentifier = "CodeLanguageCell"
    private let kTableViewCellIdentifier = "RepositoryCell"
    private let kNavigationTitleViewName = "RepositoriesListNavigationTitleView"

    // MARK: - Private Properties

    private var viewModel: RepositoriesListViewModel?
    private var languageCells: [CodeLanguageCell] = []
    private var isRefreshing = false

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupViewModel()
        setupCollectionView()
        setupTableView()
    }

    // MARK: - Private Properties

    private func selectFirstButton() {
        let firstOption = languageCells.first
        firstOption?.setSelected()
        getRepositoriesList(language: firstOption?.language ?? .java)
    }

    private func setupNavigation() {
        let navigationTitleView = UINib(nibName: kNavigationTitleViewName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView
        navigationItem.titleView = navigationTitleView
        navigationController?.clearNavigation()
        navigationItem.title = .empty
    }

    private func errorOcurred() {
        let alert = UIAlertController(title: LocalizedStrings.errorTitle.localized(),
                                      message: LocalizedStrings.apiErrorMessage.localized(),
                                      preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: LocalizedStrings.okButtonTitle.localized(),
                                     style: .cancel)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }

    private func setupCollectionView() {
        let nib = UINib(nibName: kCollectionViewIdentifier, bundle: nil)
        codeLanguageCollectionView.register(nib, forCellWithReuseIdentifier: kCollectionViewIdentifier)
        codeLanguageCollectionView.dataSource = self
        codeLanguageCollectionView.delegate = self
    }

    private func setupTableView() {
        let nib = UINib(nibName: kTableViewCellIdentifier, bundle: nil)
        repositoriesTableView.register(nib, forCellReuseIdentifier: kTableViewCellIdentifier)
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
    }

    private func unselectAllLanguageOptions() {
        languageCells.forEach { cell in
            cell.setUnselected()
        }
    }

    private func setupViewModel() {
        viewModel = RepositoriesListViewModel(services: Session.service)
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
                self.isRefreshing = false
                self.repositoriesTableView.reloadData()
            }
        }, failure: { error in
            DispatchQueue.main.async {
                self.isRefreshing = false
                self.errorOcurred()
            }
        })
    }

    private func openPullRequestsScreen(pullRequests: [PullRequest], repositoryName: String?) {
        let viewModel = PullRequestsViewModel(model: pullRequests)
        let coordinator = PullRequestsCoordinator(viewModel: viewModel,
                                                  repositoryName: repositoryName ?? .empty)
        coordinator.start(navigationController: self.navigationController)
    }
}

// MARK: - Tableview Delegate

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.repositoriesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellIdentifier, for: indexPath) as? RepositoryCell, let repository = viewModel?.getRepository(position: indexPath.row)  else { return UITableViewCell() }
        let cellViewModel = RepositoryCellViewModel(model: repository, service: Session.service)
        cell.setup(viewModel: cellViewModel)
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if !isRefreshing {
            if offsetY > contentHeight - scrollView.frame.height {
                isRefreshing = true
                getRepositoriesListNextPage()
            }
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            self.repositoriesTableView.tableFooterView = spinner
            self.repositoriesTableView.tableFooterView?.isHidden = false
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showLoading()
        viewModel?.getPullRequestsList(
            position: indexPath.row,
            success: { list in
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.openPullRequestsScreen(pullRequests: list,
                                                repositoryName: self.viewModel?.getSelectedRepositoryName(position: indexPath.row))
                }
            },
            failure: { error in
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.errorOcurred()
                }
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
        selectFirstButton()
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
