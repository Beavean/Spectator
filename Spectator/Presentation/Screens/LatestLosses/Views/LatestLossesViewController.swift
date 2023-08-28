//
//  LatestLossesViewController.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

final class LatestLossesViewController: UIViewController {
    // MARK: - UI Elements

    private lazy var lossesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout().apply {
            $0.minimumInteritemSpacing = mediumPadding
            $0.minimumLineSpacing = mediumPadding
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).apply {
            $0.contentInset = UIEdgeInsets(top: mediumPadding,
                                           left: mediumPadding,
                                           bottom: mediumPadding,
                                           right: mediumPadding)
            $0.dataSource = self
            $0.delegate = self
            $0.register(LossesCell.self, forCellWithReuseIdentifier: LossesCell.reuseIdentifier)
            $0.register(LossesHeaderView.self,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: LossesHeaderView.reuseIdentifier)
        }
        return collectionView
    }()

    private let headerView = LossesHeaderView()

    // MARK: - Properties

    private let mediumPadding = Constants.StyleDefaults.mediumPadding
    private let cellHeight: CGFloat = 100
    private let headerHeight: CGFloat = 100
    private let viewModel: LatestLossesViewModel

    // MARK: - Initialization

    init(viewModel: LatestLossesViewModel) {
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
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    // MARK: - Setup

    private func setupUI() {
        view.addSubview(lossesCollectionView)
        lossesCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                    left: view.safeAreaLayoutGuide.leftAnchor,
                                    bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                    right: view.safeAreaLayoutGuide.rightAnchor)
    }
}

// MARK: - UICollectionViewDataSource

extension LatestLossesViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        viewModel.numberOfLossTypes
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LossesCell.reuseIdentifier,
                                                            for: indexPath) as? LossesCell,
            let todayLosses = viewModel.getLossesForIndex(indexPath.item)
        else { return UICollectionViewCell() }
        cell.configure(with: todayLosses)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let id = LossesHeaderView.reuseIdentifier
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: id,
                                                                           for: indexPath) as? LossesHeaderView,
              let latestLosses = viewModel.losses.personnelLosses?.last
        else { return UICollectionReusableView() }
        header.configure(withDay: latestLosses.day, date: latestLosses.date)
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LatestLossesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout _: UICollectionViewLayout,
                        referenceSizeForHeaderInSection _: Int) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: headerHeight)
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = UIScreen.main.bounds.width - mediumPadding * 2
        if indexPath.row == 0 {
            return CGSize(width: availableWidth, height: cellHeight)
        } else {
            let width = (availableWidth - mediumPadding) / 2
            return CGSize(width: width, height: cellHeight)
        }
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        insetForSectionAt _: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: mediumPadding, right: 0)
    }
}

// MARK: - UICollectionViewDelegate

extension LatestLossesViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let lossType = viewModel.getLossesTypeForIndex(indexPath.item) else { return }
        let viewModel = DateLossesViewModel(losses: viewModel.losses, lossType: lossType)
        let viewController = DateLossesViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
