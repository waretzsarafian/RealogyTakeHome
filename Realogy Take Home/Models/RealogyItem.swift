//
//  RealogyItem.swift
//  Realogy Take Home
//
//  Created by Brett Sarafian on 5/26/23.
//

import Foundation
import UIKit

struct RealogyResponse: Codable {
    var RelatedTopics: [RealogyResponseItem]
}

struct RealogyResponseItem: Codable {
    var Icon: RealogyIcon
    var Text: String
}

struct RealogyIcon: Codable {
    var URL: String?
}

extension RealogyResponseItem {
    var realogyItem: RealogyItem {
        return RealogyItem(name: Text, iconString: Icon.URL)
    }
}

struct RealogyItem: Hashable {
    var text: String = ""

    var id: UUID?
    var name: String = ""
    var iconString: String?
    var description: String = ""

    init(name: String = "", iconString: String?) {
        self.id = UUID()
        self.name = getName(name)
        self.iconString = iconString
        self.description = getDescription(name)
    }

    private func getName(_ text: String) -> String {
        text.components(separatedBy: "-").first ?? ""
    }

    private func getDescription(_ text: String) -> String {
        return text.components(separatedBy: " - ").last ?? ""
    }
}
