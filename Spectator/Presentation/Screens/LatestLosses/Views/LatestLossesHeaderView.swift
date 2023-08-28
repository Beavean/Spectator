//
//  LatestLossesHeaderView.swift
//  Spectator
//
//  Created by Beavean on 28.08.2023.
//

import UIKit

final class LossesHeaderView: UICollectionReusableView, ReuseIdentifier {
    // MARK: - UI Elements

    private let titleLabel = CustomStyleLabel(fontSize: 30,
                                              isBold: true,
                                              alignment: .center)

    private let subtitleLabel = CustomStyleLabel(text: LocalizedString.lossesInfo.localized,
                                                 fontSize: 12,
                                                 alignment: .center,
                                                 numberOfLines: 2)

    private lazy var stackView = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fillEqually
    }

    // MARK: - Properties

    private let mediumPadding = Constants.StyleDefaults.mediumPadding
    private lazy var insets = UIEdgeInsets(top: mediumPadding,
                                           left: mediumPadding,
                                           bottom: mediumPadding,
                                           right: mediumPadding)

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup

    private func setupUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.fillSuperview(padding: insets)
    }

    // MARK: - Public Functions

    func configure(withDay day: Int, date: String) {
        titleLabel.text = day.toString() + " " + LocalizedString.daysOfWar.localized
        guard let dateString = date.formatDate() else { return }
        subtitleLabel.text = LocalizedString.lossesInfo.localized + " for " + dateString
    }
}
