//
//  Array+SafeElement.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

extension Array {
    func safeElement(at index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
}
