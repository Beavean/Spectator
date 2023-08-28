//
//  LossesCell.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

final class LossesCell: UICollectionViewCell, ReuseIdentifier {
    // MARK: - UI Elements

    private let containerView = UIView().apply {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = Constants.StyleDefaults.cornerRadius
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.gray.cgColor
    }

    private let lossesTypeLabel = CustomStyleLabel()

    private let totalLossesLabel = CustomStyleLabel(fontSize: 22, isBold: true)

    private let todayLossesLabel = CustomStyleLabel(fontSize: 18, fontColor: Constants.Colors.primaryAccentColor.color)

    private let badgeImageView = UIImageView().apply {
        $0.image = Constants.SystemImage.chevronRight.image
        $0.tintColor = Constants.Colors.secondaryLabel.color
    }

    private let leadingBadgeImageView = UIImageView().apply {
        $0.image = Constants.SystemImage.circleFilled.image
        $0.tintColor = Constants.Colors.secondaryLabel.color
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

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with loss: TodayLosses) {
        lossesTypeLabel.text = loss.lossType.title
        totalLossesLabel.text = loss.totalLosses
        guard loss.todayLosses != "0" else {
            todayLossesLabel.text = ""
            leadingBadgeImageView.image = Constants.SystemImage.circle.image
            leadingBadgeImageView.tintColor = Constants.Colors.secondaryLabel.color
            return
        }
        todayLossesLabel.text = "+" + loss.todayLosses
        leadingBadgeImageView.image = Constants.SystemImage.circleInsetFilled.image
        leadingBadgeImageView.tintColor = Constants.Colors.primaryAccentColor.color
    }

    // MARK: - Setup

    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.fillSuperview()
        containerView.addSubview(stackView)
        stackView.anchor(top: containerView.topAnchor,
                         left: containerView.leftAnchor,
                         bottom: containerView.bottomAnchor,
                         right: containerView.rightAnchor,
                         paddingTop: smallPadding,
                         paddingLeft: smallPadding,
                         paddingBottom: smallPadding,
                         paddingRight: smallPadding)
        stackView.addArrangedSubview(lossesTypeLabel)
        lossesTypeLabel.setHeight(lossesTypeLabelHeight)
        stackView.addArrangedSubview(totalLossesLabel)
        containerView.addSubview(todayLossesLabel)
        todayLossesLabel.anchor(top: totalLossesLabel.topAnchor,
                                left: totalLossesLabel.rightAnchor,
                                paddingLeft: smallPadding / 2)
        containerView.addSubview(badgeImageView)
        badgeImageView.centerY(inView: containerView)
        badgeImageView.anchor(right: containerView.rightAnchor, paddingRight: smallPadding)
        containerView.addSubview(leadingBadgeImageView)
        leadingBadgeImageView.centerY(inView: containerView)
        leadingBadgeImageView.anchor(left: containerView.leftAnchor, paddingLeft: smallPadding)
    }
}
