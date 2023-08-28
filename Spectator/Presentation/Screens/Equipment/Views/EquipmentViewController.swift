//
//  EquipmentViewController.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

final class EquipmentViewController: UIViewController {
    // MARK: - UI Elements

    private lazy var tableView = UITableView().apply {
        $0.dataSource = self
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(EquipmentLossesCell.self, forCellReuseIdentifier: EquipmentLossesCell.reuseIdentifier)
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).apply {
            $0.delegate = self
            $0.contentInset = UIEdgeInsets(top: 0, left: mediumPadding, bottom: 0, right: mediumPadding)
            $0.contentInsetAdjustmentBehavior = .never
            $0.showsHorizontalScrollIndicator = false
            $0.dataSource = self
            $0.register(EquipmentTypeCell.self, forCellWithReuseIdentifier: EquipmentTypeCell.reuseIdentifier)
        }
        return collectionView
    }()

    private lazy var searchBar = UISearchBar().apply {
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.barTintColor = .clear
        $0.isTranslucent = true
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.backgroundImage = UIImage()
        $0.textContentType = .none
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.spellCheckingType = .no
        $0.smartQuotesType = .no
    }

    // MARK: - Properties

    private let mediumPadding = Constants.StyleDefaults.mediumPadding
    private let typeCellHeight: CGFloat = 36
    private let bigElementHeight: CGFloat = 52
    private var viewModel: EquipmentViewModel

    // MARK: - Initialization

    init(viewModel: EquipmentViewModel) {
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
        title = LocalizedString.equipmentTab.localized
        setupUI()
    }

    // MARK: - Setup

    private func setupUI() {
        view.addSubview(searchBar)
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         height: bigElementHeight)
        view.addSubview(collectionView)
        collectionView.anchor(top: searchBar.bottomAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              height: bigElementHeight)
        view.addSubview(tableView)
        tableView.anchor(top: collectionView.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: mediumPadding)
    }
}

// MARK: - UICollectionViewDataSource

extension EquipmentViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        viewModel.numberOfEquipmentTypes
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EquipmentTypeCell.reuseIdentifier,
                                                            for: indexPath) as? EquipmentTypeCell,
            let type = viewModel.getEquipmentType(forIndex: indexPath.item)
        else { return UICollectionViewCell() }
        let isSelected = viewModel.isEquipmentTypeCellSelected(atIndex: indexPath.item)
        cell.configure(withType: type, isSelected: isSelected)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension EquipmentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let equipmentType = viewModel.getEquipmentType(forIndex: indexPath.item) {
            let text = equipmentType.rawValue
            let font = UIFont.systemFont(ofSize: mediumPadding)
            let width = text.size(withAttributes: [NSAttributedString.Key.font: font]).width + mediumPadding
            return CGSize(width: width, height: typeCellHeight)
        }
        return CGSize(width: typeCellHeight, height: typeCellHeight)
    }
}

// MARK: - UICollectionViewDelegate

extension EquipmentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedEquipment = EquipmentType.allCases[indexPath.row]
        viewModel.filterByEquipmentUa(selectedEquipment)
        tableView.reloadData()
        collectionView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension EquipmentViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.resetFilters()
        } else {
            viewModel.filterByModel(searchText)
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.resetFilters()
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource

extension EquipmentViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.numberOfEquipmentItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EquipmentLossesCell.reuseIdentifier,
                                                       for: indexPath) as? EquipmentLossesCell,
            let loss = viewModel.loss(at: indexPath.row)
        else { return UITableViewCell() }
        cell.configure(with: loss)
        return cell
    }
}
