//
//  MainTabBarViewModel.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

final class MainTabBarViewModel {
    let losses: Losses

    var tabs: [TabBarItem] {
        TabBarItem.allCases
    }

    init(losses: Losses) {
        self.losses = losses
    }
}
