//
//  SplashViewModel.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

final class SplashViewModel {
    private let networkManager = NetworkManager()
    private let storageManager = StorageManager()

    var losses = Losses()
    var error: DataLoadingError?

    func fetchAllLosses(completion: @escaping (Result<LossesLoadingResult, DataLoadingError>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var errorOccurred = false

        dispatchGroup.enter()
        fetchEquipmentLosses { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                losses.equipmentLosses = data
            case let .failure(error):
                self.error = error
                errorOccurred = true
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        fetchPersonnelLosses { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                losses.personnelLosses = data
            case let .failure(error):
                self.error = error
                errorOccurred = true
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        fetchEquipmentOryxLosses { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                losses.equipmentOryxLosses = data
            case let .failure(error):
                self.error = error
                errorOccurred = true
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [self] in
            if errorOccurred {
                completion(.failure(.noNetworkAndLocalData))
            } else {
                let lossesResult = LossesLoadingResult(losses: losses, error: error)
                completion(.success(lossesResult))
            }
        }
    }

    private func fetchEquipmentLosses(completion: @escaping (Result<[EquipmentLoss], DataLoadingError>) -> Void) {
        networkManager.fetchEquipmentLosses { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(equipmentLosses):
                completion(.success(equipmentLosses))
            case let .failure(error):
                self.error = error
                self.storageManager.getEquipmentLosses { result in
                    switch result {
                    case let .success(equipmentLosses):
                        completion(.success(equipmentLosses))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    private func fetchPersonnelLosses(completion: @escaping (Result<[PersonnelLoss], DataLoadingError>) -> Void) {
        networkManager.fetchPersonnelLosses { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(personnelLosses):
                completion(.success(personnelLosses))
            case let .failure(error):
                self.error = error
                self.storageManager.getPersonnelLosses { result in
                    switch result {
                    case let .success(personnelLosses):
                        completion(.success(personnelLosses))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    private func fetchEquipmentOryxLosses(completion: @escaping (Result<[OryxLoss], DataLoadingError>) -> Void) {
        networkManager.fetchEquipmentOryxLosses { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(equipmentOryxLosses):
                completion(.success(equipmentOryxLosses))
            case let .failure(error):
                self.error = error
                self.storageManager.getEquipmentOryxLosses { result in
                    switch result {
                    case let .success(equipmentOryxLosses):
                        completion(.success(equipmentOryxLosses))
                    case let .failure(error):
                        self.error = error
                        completion(.failure(.noNetworkAndLocalData))
                    }
                }
            }
        }
    }
}
