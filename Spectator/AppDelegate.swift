//
//  AppDelegate.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .dark
        window?.rootViewController = SplashViewController()
        setupAppearances()
        return true
    }

    private func setupAppearances() {
        UICollectionViewCell.appearance().backgroundColor = .clear
        UICollectionView.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = Constants.Colors.primaryAccentColor.color
    }
}
