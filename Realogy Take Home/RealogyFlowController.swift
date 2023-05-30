//
//  RealogyFlowController.swift
//  Realogy Take Home
//
//  Created by Brett Sarafian on 5/30/23.
//

import Foundation
import UIKit


public class RealogyFlowController: UINavigationController {

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public init(urlString: String) {
        let viewModel = RealogyViewModel(urlString: urlString)
        super.init(rootViewController: RealogyViewController(viewModel: viewModel))

    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
