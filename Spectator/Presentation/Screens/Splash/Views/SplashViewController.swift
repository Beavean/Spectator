//
//  SplashViewController.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

final class SplashViewController: UIViewController {
    // MARK: - UI Elements

    private let appNameLabel = CustomStyleLabel(text: LocalizedString.appName.localized,
                                                fontSize: 36,
                                                fontColor: Constants.Colors.background.color,
                                                isBold: true,
                                                alignment: .center)

    // MARK: - Properties

    private let mediumPadding = Constants.StyleDefaults.mediumPadding
    private var viewModel = SplashViewModel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLogoViewZooming()
    }

    // MARK: - Helpers

    private func fetchLosses() {
        viewModel.fetchAllLosses { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(lossesResult):
                if let error = lossesResult.error {
                    showAlert(message: error.localizedDescription) { _ in
                        self.presentMainTabBarController(forLosses: lossesResult.losses)
                    }
                } else {
                    presentMainTabBarController(forLosses: lossesResult.losses)
                }
            case let .failure(failure):
                showAlert(title: LocalizedString.criticalErrorTitle.localized,
                          message: failure.localizedDescription,
                          okActionTitle: LocalizedString.retryButtonText.localized) { _ in
                    self.fetchLosses()
                }
            }
        }
    }

    private func showAlert(title: String? = LocalizedString.errorTitle.localized,
                           message: String,
                           okActionTitle: String = LocalizedString.okButtonText.localized,
                           okAction: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: okAction)
        okAction.setValue(Constants.Colors.primaryAccentColor.color, forKey: "titleTextColor")
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    private func presentMainTabBarController(forLosses losses: Losses) {
        let viewModel = MainTabBarViewModel(losses: losses)
        let mainTabViewController = MainTabBarController(viewModel: viewModel)
        mainTabViewController.modalPresentationStyle = .fullScreen
        present(mainTabViewController, animated: true, completion: nil)
    }

    // MARK: - Setup

    private func setupUI() {
        addGradientBackgroundWithAnimation()
        view.addSubview(appNameLabel)
        appNameLabel.center(inView: view)
        appNameLabel.anchor(left: view.leftAnchor,
                            right: view.leftAnchor,
                            paddingLeft: mediumPadding,
                            paddingRight: mediumPadding)
    }

    // MARK: - Animation

    private func animateLogoViewZooming() {
        let zoomScale: CGFloat = 1.2
        let zoomDuration = 1.0
        let originalTransform = appNameLabel.transform
        UIView.animateKeyframes(withDuration: zoomDuration * 2,
                                delay: 0,
                                options: [.autoreverse],
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.appNameLabel.transform = originalTransform.scaledBy(x: zoomScale, y: zoomScale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.appNameLabel.transform = originalTransform
            }
        }) { [weak self] finished in
            if finished {
                self?.fetchLosses()
            }
        }
    }
}
