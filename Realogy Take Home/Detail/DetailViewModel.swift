//
//  DetailViewModel.swift
//  Realogy Take Home
//
//  Created by Brett Sarafian on 5/30/23.
//

import Foundation
import UIKit

protocol DetailUpdatable {
    func imageDidUpdate()
}

class DetailViewModel {
    var delegate: DetailUpdatable?

    var name: String
    var description: String
    var iconString: String?
    var iconImage: UIImage?

    init(_ item: RealogyItem) {
        self.name = item.name
        self.description = item.description
        Task.init {
            self.iconImage = try await getImage(item.iconString)
            self.delegate?.imageDidUpdate()
        }
    }

    func getImage(_ urlString: String?) async throws -> UIImage? {
        if iconImage != nil {
            return iconImage
        } else if urlString == "" {
            return nil
        }

        guard let imageString = urlString,
              let url = URL(string: "https://duckduckgo.com" + imageString) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }
}
