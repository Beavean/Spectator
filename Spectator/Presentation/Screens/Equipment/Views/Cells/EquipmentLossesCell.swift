//
//  EquipmentLossesCell.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

final class EquipmentLossesCell: UITableViewCell, ReuseIdentifier {
    // MARK: - UI Elements

    private let equipmentImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.setDimensions(height: 40, width: 40)
        $0.tintColor = Constants.Colors.primaryAccentColor.color
    }

    private let nameLabel = CustomStyleLabel(fontSize: 16)

    private let descriptionLabel = CustomStyleLabel(fontSize: 14,
                                                    fontColor: Constants.Colors.secondaryLabel.color)

    private let rightLabel = CustomStyleLabel(fontSize: 24,
                                              fontColor: Constants.Colors.primaryAccentColor.color,
                                              isBold: true,
                                              alignment: .right)

    private let verticalStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 5
    }

    private let horizontalStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fillProportionally
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Properties

    private let mediumPadding = Constants.StyleDefaults.mediumPadding
    private let smallPadding = Constants.StyleDefaults.smallPadding

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure

    func configure(with loss: OryxLoss) {
        nameLabel.text = loss.model
        equipmentImageView.image = loss.equipmentType.image
        descriptionLabel.text = loss.manufacturer.rawValue
        rightLabel.text = "\(loss.lossesTotal)"
    }

    // MARK: - Setup

    private func setupUI() {
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(equipmentImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(rightLabel)
        rightLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        horizontalStackView.fillSuperview(padding: UIEdgeInsets(top: smallPadding,
                                                                left: mediumPadding,
                                                                bottom: smallPadding,
                                                                right: mediumPadding))
    }
}
