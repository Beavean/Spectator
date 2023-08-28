//
//  SettingsCell.swift
//  Spectator
//
//  Created by Beavean on 28.08.2023.
//

import UIKit

final class SettingsCell: UITableViewCell, ReuseIdentifier {
    // MARK: - UI Elements

    private let containerView = UIView().apply {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = Constants.StyleDefaults.cornerRadius
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.gray.cgColor
    }

    private let titleLabel = CustomStyleLabel()

    private let badgeImageView = UIImageView().apply {
        $0.image = Constants.SystemImage.chevronRight.image
        $0.tintColor = Constants.Colors.secondaryLabel.color
    }

    private let leadingBadgeImageView = UIImageView().apply {
        $0.image = Constants.SystemImage.circleFilled.image
        $0.tintColor = Constants.Colors.primaryAccentColor.color
    }

    private let stackView = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .center
    }

    // MARK: - Properties

    private let lossesTypeLabelHeight: CGFloat = 36
    private let smallPadding: CGFloat = Constants.StyleDefaults.smallPadding
    private let mediumPadding = Constants.StyleDefaults.mediumPadding
    private lazy var insets = UIEdgeInsets(top: mediumPadding,
                                           left: mediumPadding,
                                           bottom: mediumPadding,
                                           right: mediumPadding)

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with element: SettingElement) {
        titleLabel.text = element.title
    }

    // MARK: - Setup

    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.fillSuperview(padding: insets)
        containerView.addSubview(stackView)
        stackView.anchor(top: containerView.topAnchor,
                         left: containerView.leftAnchor,
                         bottom: containerView.bottomAnchor,
                         right: containerView.rightAnchor,
                         paddingTop: smallPadding,
                         paddingLeft: smallPadding,
                         paddingBottom: smallPadding,
                         paddingRight: smallPadding)
        stackView.addArrangedSubview(titleLabel)
        titleLabel.setHeight(lossesTypeLabelHeight)
        containerView.addSubview(badgeImageView)
        badgeImageView.centerY(inView: containerView)
        badgeImageView.anchor(right: containerView.rightAnchor, paddingRight: smallPadding)
        containerView.addSubview(leadingBadgeImageView)
        leadingBadgeImageView.centerY(inView: containerView)
        leadingBadgeImageView.anchor(left: containerView.leftAnchor, paddingLeft: smallPadding)
    }
}
