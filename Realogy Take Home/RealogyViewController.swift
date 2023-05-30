//
//  ViewController.swift
//  Realogy Take Home
//
//  Created by Brett Sarafian on 5/25/23.
//

import UIKit

class RealogyViewController: UIViewController {
    var viewModel: RealogyViewModel

    private var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Search"
        return view
    }()

    private var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.register(UITableViewCell.self, forCellReuseIdentifier: "RealogyCell")
        return view
    }()

    init(viewModel: RealogyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.configDataSource(tableView)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        setupUI()
    }

    private func setupUI() {
        let safeArea = self.view.safeAreaLayoutGuide

        self.view.addSubview(searchBar)
        searchBar.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60)
        ])

        self.view.addSubview(tableView)
        tableView.delegate = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension RealogyViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.updateSnapshot(viewModel.characterData, animated: true)
        }
        let filteredResult = viewModel.characterData.filter({$0.name.starts(with: searchText)})
        viewModel.updateSnapshot(filteredResult, animated: true)
    }
}

extension RealogyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.characterData[indexPath.row]
        let viewModel = DetailViewModel(item)
        let viewController = DetailViewController(viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

