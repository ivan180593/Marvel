//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import UIKit

final class CharacterListViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private enum Section {
        case main
    }
    private var dataSource: UICollectionViewDiffableDataSource<Section, CharacterListModel.ViewModel>!
    var presenter: CharacterListPresenterProtocol?
    var router: CharacterListRouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel"
        setupCollectionView()
        presenter?.getCharacters()
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == CharacterListRouter.Segue.detail,
              let destination = segue.destination as? CharacterDetailViewController,
              let indexPath = collectionView.indexPathsForSelectedItems?.first,
              let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        router?.configureDetail(destination, characterId: item.id, title: item.name)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: Private methods
private extension CharacterListViewController {
    func setupCollectionView() {
        setupCollectionViewLayout()
        setupDataSource()
    }
    
    func setupCollectionViewLayout() {
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
    }
    
    func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CharacterListModel.ViewModel> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.name
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, CharacterListModel.ViewModel>(collectionView: collectionView) { collectionView, indexPath, identifier -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    func applySnapshot(items: [CharacterListModel.ViewModel]) {
        // Initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, CharacterListModel.ViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: UICollectionViewDelegate
extension CharacterListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.showDetail(from: self)
    }
}

// MARK: CharacterListViewProtocol
extension CharacterListViewController: CharacterListViewProtocol {
    func characterList(list: [CharacterListModel.ViewModel]) {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
        applySnapshot(items: list)
    }
    
    func hideActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    
    func showError(_ error: String) {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()

            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Retry", style: .default) { (alert) in
                self.activityIndicatorView.startAnimating()
                self.presenter?.getCharacters()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
                alertController.dismiss(animated: true)
            }
            alertController.addAction(retryAction)
            alertController.addAction(cancelAction)
            self.navigationController?.present(alertController, animated: true)
        }
    }
}
