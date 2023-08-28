//
//  NetworkManager.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

final class NetworkManager {
    private let networkConnectionCheckUrl = "https://www.apple.com"

    func fetchEquipmentLosses(completion: @escaping (Result<[EquipmentLoss], DataLoadingError>) -> Void) {
        fetchData(from: .equipmentLosses, completion: completion)
    }

    func fetchPersonnelLosses(completion: @escaping (Result<[PersonnelLoss], DataLoadingError>) -> Void) {
        fetchData(from: .personnelLosses, completion: completion)
    }

    func fetchEquipmentOryxLosses(completion: @escaping (Result<[OryxLoss], DataLoadingError>) -> Void) {
        fetchData(from: .equipmentOryxLosses, completion: completion)
    }

    private func fetchData<T: Codable>(from dataSource: DataSource,
                                       completion: @escaping (Result<[T], DataLoadingError>) -> Void) {
        checkInternetConnection { isConnected in
            guard isConnected else {
                completion(.failure(.noInternetConnection))
                return
            }
            guard let url = URL(string: dataSource.urlString) else {
                completion(.failure(.invalidURL))
                return
            }
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                let storageManager = StorageManager()
                storageManager.saveJSON(data: data, for: dataSource)
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode([T].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(.decodingError))
                }
            }.resume()
        }
    }

    private func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: networkConnectionCheckUrl) else {
            completion(false)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { _, response, _ in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(true)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
}
