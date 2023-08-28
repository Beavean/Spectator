//
//  ReuseIdentifier.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

protocol ReuseIdentifier {}

extension ReuseIdentifier {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
