//
//  SecondaryLabel.swift
//  Spectator
//
//  Created by Beavean on 28.08.2023.
//

import UIKit

final class CustomStyleLabel: UILabel {
    init(text: String? = nil,
         fontSize: CGFloat? = 16,
         fontColor: UIColor? = Constants.Colors.label.color,
         isBold: Bool = false,
         alignment: NSTextAlignment? = .left,
         numberOfLines: Int = 1) {
        super.init(frame: .zero)
        setLabelProperties(text: text, fontSize: fontSize, fontColor: fontColor, isBold: isBold, alignment: alignment)
        self.numberOfLines = numberOfLines
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLabelProperties(text: String? = nil,
                            fontSize: CGFloat? = nil,
                            fontColor: UIColor? = nil,
                            isBold: Bool = false,
                            alignment: NSTextAlignment? = nil) {
        if let text = text {
            self.text = text
        }
        if let fontSize = fontSize {
            font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        }
        if let fontColor = fontColor {
            textColor = fontColor
        }
        if let alignment = alignment {
            textAlignment = alignment
        }
    }
}
