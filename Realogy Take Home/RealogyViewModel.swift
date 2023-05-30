//
//  ViewModel.swift
//  Realogy Take Home
//
//  Created by Brett Sarafian on 5/26/23.
//

import UIKit
import Foundation

class RealogyViewModel {
    typealias DataSource = UITableViewDiffableDataSource<Int, RealogyItem>

    var dataSource: DataSource?

    var urlString: String

    var characterData: [RealogyItem] = [RealogyItem]()

    init(urlString: String) {
        self.urlString = urlString
        Task.init {
            characterData = try await getData()
            updateSnapshot(characterData)
        }
    }

    private func getData() async throws -> [RealogyItem]  {
        guard let url = URL(string: urlString) else { return []}

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(RealogyResponse.self, from: data)
        return decoded.RelatedTopics.map({ $0.realogyItem })
    }

    func updateSnapshot(_ items: [RealogyItem], animated: Bool = false) {
        guard let dataSource = dataSource else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Int, RealogyItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)

        DispatchQueue.main.async {
            dataSource.apply(snapshot, animatingDifferences: animated)
        }
    }

    func configDataSource(_ tableView: UITableView) {
        dataSource = UITableViewDiffableDataSource<Int, RealogyItem>(tableView: tableView) { tableView, indexPath, realogyItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: "RealogyCell")
            var contentConfiguration = UIListContentConfiguration.cell()
            contentConfiguration.text = realogyItem.name
            cell?.contentConfiguration = contentConfiguration
            return cell
        }
        updateSnapshot(characterData)
    }
}
