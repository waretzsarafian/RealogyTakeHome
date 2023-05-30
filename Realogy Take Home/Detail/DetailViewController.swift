//
//  DetailViewController.swift
//  Realogy Take Home
//
//  Created by Brett Sarafian on 5/30/23.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var viewModel: DetailViewModel

    var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var detailImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()

    init(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        setupUI()
    }

    private func setupUI() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.title = viewModel.name
        self.view.backgroundColor = .white

        self.view.addSubview(detailImageView)
        detailImageView.image = UIImage(imageLiteralResourceName: "placeholder")
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            detailImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])

        self.view.addSubview(descriptionLabel)
        descriptionLabel.text = viewModel.description
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 44),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),

        ])
    }
}

extension DetailViewController: DetailUpdatable {
    func imageDidUpdate() {
        DispatchQueue.main.async {
            self.detailImageView.image = self.viewModel.iconImage
        }
    }

    
}
