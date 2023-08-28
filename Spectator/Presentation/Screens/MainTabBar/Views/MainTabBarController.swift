//
//  MainTabBarController.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - Properties

    private let primaryAccentColor = Constants.Colors.primaryAccentColor.color
    private let viewModel: MainTabBarViewModel

    // MARK: - Initialization

    init(viewModel: MainTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        configureViewControllers()
    }

    // MARK: - Configuration

    private func setupAppearance() {
        tabBar.tintColor = primaryAccentColor
    }

    private func configureViewControllers() {
        var tabViewControllers = [UIViewController]()
        viewModel.tabs.forEach { tab in
            let viewController: UIViewController
            switch tab {
            case .lossesTab:
                let latestLossesViewModel = LatestLossesViewModel(losses: viewModel.losses)
                let latestLossesViewController = LatestLossesViewController(viewModel: latestLossesViewModel)
                let navigationController = UINavigationController(rootViewController: latestLossesViewController)
                viewController = navigationController
            case .equipmentTab:
                let viewModel = EquipmentViewModel(losses: viewModel.losses.equipmentOryxLosses)
                let equipmentViewController = EquipmentViewController(viewModel: viewModel)
                let navigationController = UINavigationController(rootViewController: equipmentViewController)
                viewController = navigationController
            case .moreTab:
                let navigationController = UINavigationController(rootViewController: SettingsViewController())
                viewController = navigationController
            }
            viewController.tabBarItem = UITabBarItem(title: tab.title,
                                                     image: tab.image,
                                                     selectedImage: tab.selectedImage)
            tabViewControllers.append(viewController)
        }
        viewControllers = tabViewControllers
    }
}
