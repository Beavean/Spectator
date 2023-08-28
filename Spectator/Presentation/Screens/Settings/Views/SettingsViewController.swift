//
//  SettingsViewController.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import SafariServices
import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - UI Elements

    private lazy var settingsTableView = UITableView().apply {
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
    }

    // MARK: - Properties

    private let settingElements = SettingElement.allCases

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientBackgroundWithAnimation(topColor: Constants.Colors.secondaryBackground.color,
                                           bottomColor: Constants.Colors.background.color)
        setupUI()
    }

    // MARK: - Setup UI

    private func setupUI() {
        view.addSubview(settingsTableView)
        settingsTableView.fillSuperview()
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return settingElements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier,
                                                       for: indexPath) as? SettingsCell
        else { return UITableViewCell() }
        let setting = settingElements[indexPath.row]
        cell.configure(with: setting)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let setting = settingElements[indexPath.row]
        guard let url = URL(string: setting.urlString) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
