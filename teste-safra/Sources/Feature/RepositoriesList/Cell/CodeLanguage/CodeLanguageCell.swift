//
//  CodeLanguageCell.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import UIKit

class CodeLanguageCell: UICollectionViewCell {

    // MARK: - Storyboard Outlets

    @IBOutlet var codeLanguageButton: UIButton!

    // MARK: Private Properties

    private var viewModel: CodeLanguageCellViewModel?
    private weak var controllerDelegate: RepositoriesViewControllerDelegate?

    // MARK: - Public Methods

    func setup(viewModel: CodeLanguageCellViewModel, controllerDelegate: RepositoriesViewControllerDelegate) {
        self.viewModel = viewModel
        self.controllerDelegate = controllerDelegate
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        setUnselected()
        codeLanguageButton.setTitle(viewModel?.language.rawValue, for: .normal)
    }

    // MARK: - Public Methods

    func setUnselected() {
        codeLanguageButton.backgroundColor = UIColor.clear
        codeLanguageButton.layer.borderWidth = 1
        codeLanguageButton.setTitleColor(viewModel?.buttonColor, for: .normal)
        codeLanguageButton.layer.borderColor = viewModel?.buttonColor.cgColor
        codeLanguageButton.layer.cornerRadius = 10
    }

    func setSelected() {
        codeLanguageButton.layer.borderWidth = 0
        codeLanguageButton.setTitleColor(.white, for: .normal)
        codeLanguageButton.backgroundColor = viewModel?.buttonColor
        codeLanguageButton.layer.cornerRadius = 10
    }

    var language: CodeLanguage? {
        viewModel?.language
    }

    // MARK: - Storyboard Actions

    @IBAction func codeLanguageButtonDidTapped(_ sender: Any) {
        controllerDelegate?.changeCodeLanguage(language: viewModel?.language ?? .swift)
        setSelected()
    }
}
