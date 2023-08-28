//
//  DateLossesViewController.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

final class DateLossesViewController: UIViewController {
    // MARK: - UI Elements

    private lazy var tableView = UITableView().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.allowsSelection = false
        $0.register(DateLossesCell.self, forCellReuseIdentifier: DateLossesCell.reuseIdentifier)
    }

    // MARK: - Properties

    private let viewModel: DateLossesViewModel

    // MARK: - Initialization

    init(viewModel: DateLossesViewModel) {
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
        addGradientBackgroundWithAnimation(topColor: Constants.Colors.secondaryBackground.color,
                                           bottomColor: Constants.Colors.background.color)
        setupNavigationBar()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }

    // MARK: - Setup

    private func setupNavigationBar() {
        title = viewModel.lossType.title
        navigationItem.largeTitleDisplayMode = .always
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
}

// MARK: - UITableViewDataSource

extension DateLossesViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.numberOfElements
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reversedIndex = viewModel.getReversedIndex(int: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DateLossesCell.reuseIdentifier,
                                                       for: indexPath) as? DateLossesCell,
            let detailLosses = viewModel.getLosses(forIndex: reversedIndex)
        else { return UITableViewCell() }
        cell.configure(withLosses: detailLosses)
        return cell
    }
}
