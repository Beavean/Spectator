//
//  EquipmentTypeCell.swift
//  Spectator
//
//  Created by Beavean on 28.08.2023.
//

import UIKit

final class EquipmentTypeCell: UICollectionViewCell, ReuseIdentifier {
    // MARK: - UI Elements

    private var titleLabel = CustomStyleLabel(fontSize: 14, alignment: .center)

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.fillSuperview()
        setUnselected()
    }

    // MARK: - Configure

    func configure(withType type: EquipmentType, isSelected: Bool) {
        titleLabel.text = type.rawValue
        if isSelected {
            setSelected()
        } else {
            setUnselected()
        }
    }

    // MARK: - Selection Methods

    func setSelected() {
        titleLabel.textColor = Constants.Colors.background.color
        backgroundColor = Constants.Colors.primaryAccentColor.color
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 0
    }

    func setUnselected() {
        titleLabel.textColor = Constants.Colors.label.color
        backgroundColor = .clear
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 1
        layer.borderColor = Constants.Colors.label.color.cgColor
    }
}
