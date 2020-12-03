//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import UIKit

final class CharacterListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private enum Section {
        case main
    }
    private var dataSource: UITableViewDiffableDataSource<Section, CharacterModel.ViewModel>!
    var presenter: CharacterListPresenterProtocol?
    var router: CharacterListRouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel"
        setupTableView()
        presenter?.getCharacters()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == CharacterListRouter.Segue.detail,
              let destination = segue.destination as? CharacterDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let item = dataSource.itemIdentifier(for: indexPath) else { return }
        router?.configureDetail(destination, character: item, title: item.name)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Private methods
private extension CharacterListViewController {
    func setupTableView() {
        tableView.register(UINib(nibName: "\(CharacterListTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(CharacterListTableViewCell.self)")
        dataSource = UITableViewDiffableDataSource<Section, CharacterModel.ViewModel>(tableView: tableView) { tableView, indexPath, item -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CharacterListTableViewCell.self)") as? CharacterListTableViewCell else { return nil }
            cell.accessoryType = .disclosureIndicator
            cell.setItem(item)
            return cell
        }
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.isHidden = true
    }
    
    func applySnapshot(items: [CharacterModel.ViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CharacterModel.ViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: false)
        tableView.isHidden = false
    }
}

// MARK: UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.showDetail(from: self)
    }
}

// MARK: CharacterListViewProtocol
extension CharacterListViewController: CharacterListViewProtocol {
    func characterList(list: [CharacterModel.ViewModel]) {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
        applySnapshot(items: list)
    }
    
    func hideActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    
    func showError(_ error: String) {
        activityIndicatorView.stopAnimating()
        
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
        navigationController?.present(alertController, animated: true)
    }
}
