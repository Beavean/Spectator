//
//  UIViewController+NavigationBar.swift
//  Spectator
//
//  Created by Beavean on 28.08.2023.
//

import UIKit

extension UIViewController {
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
