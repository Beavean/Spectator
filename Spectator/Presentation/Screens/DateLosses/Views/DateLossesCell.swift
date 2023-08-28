//
//  DateLossesCell.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

final class DateLossesCell: UITableViewCell, ReuseIdentifier {
    // MARK: - UI Elements

    private let leadingLabel = CustomStyleLabel(fontSize: 24, alignment: .center)

    private let trailingLabel = CustomStyleLabel(fontSize: 36,
                                                 fontColor: Constants.Colors.primaryAccentColor.color,
                                                 isBold: true,
                                                 alignment: .center)

    private lazy var stackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 8
    }

    private let containerView = UIView().apply {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = Constants.StyleDefaults.cornerRadius
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.gray.cgColor
    }

    // MARK: - Properties

    private let mediumPadding = Constants.StyleDefaults.mediumPadding
    private let stackViewHeight: CGFloat = 80

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

    func configure(withLosses losses: DateLosses) {
        leadingLabel.text = losses.date.formatDate()
        trailingLabel.text = "-" + losses.dateLosses
    }

    // MARK: - Setup

    private func setupUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(containerView)
        containerView.addSubview(leadingLabel)
        leadingLabel.fillSuperview()
        stackView.addArrangedSubview(trailingLabel)
        stackView.setHeight(stackViewHeight)
        stackView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: mediumPadding,
                         paddingLeft: mediumPadding,
                         paddingBottom: mediumPadding,
                         paddingRight: mediumPadding)
    }
}
