//
//  Array+SecndToLast.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

extension Array {
    var secondToLast: Element? {
        guard count >= 2 else { return nil }
        return self[count - 2]
    }
}
