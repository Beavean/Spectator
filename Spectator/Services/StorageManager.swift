//
//  StorageManager.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

final class StorageManager {
    private let fileManager = FileManager.default
    private let fileExtension = ".json"

    func getEquipmentLosses(completion: @escaping (Result<[EquipmentLoss], DataLoadingError>) -> Void) {
        fetchAndDecode(from: .equipmentLosses, completion: completion)
    }

    func getPersonnelLosses(completion: @escaping (Result<[PersonnelLoss], DataLoadingError>) -> Void) {
        fetchAndDecode(from: .personnelLosses, completion: completion)
    }

    func getEquipmentOryxLosses(completion: @escaping (Result<[OryxLoss], DataLoadingError>) -> Void) {
        fetchAndDecode(from: .equipmentOryxLosses, completion: completion)
    }

    func saveJSON(data: Data, for dataSource: DataSource) {
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(dataSource.fileName + fileExtension)
            try? data.write(to: fileURL)
        }
    }

    private func fetchAndDecode<T: Codable>(from dataSource: DataSource,
                                            completion: @escaping (Result<[T], DataLoadingError>) -> Void) {
        guard let jsonData = loadJSON(for: dataSource) else {
            completion(.failure(.noData))
            return
        }
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([T].self, from: jsonData)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.decodingError))
        }
    }

    private func loadJSON(for dataSource: DataSource) -> Data? {
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(dataSource.fileName + fileExtension)
            if let data = try? Data(contentsOf: fileURL) {
                return data
            }
        }
        return loadJSONFromBundle(for: dataSource)
    }

    private func loadJSONFromBundle(for dataSource: DataSource) -> Data? {
        guard let path = Bundle.main.path(forResource: dataSource.fileName, ofType: fileExtension),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        else {
            return nil
        }
        return data
    }
}
