//
//  DataLoadingError.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

enum DataLoadingError: Error {
    case noInternetConnection
    case invalidURL
    case noData
    case decodingError
    case noNetworkAndLocalData

    var localizedDescription: String {
        switch self {
        case .noInternetConnection:
            return LocalizedString.noInternetConnectionError.localized
        case .invalidURL:
            return LocalizedString.invalidURLError.localized
        case .noData:
            return LocalizedString.noDataError.localized
        case .decodingError:
            return LocalizedString.decodingError.localized
        case .noNetworkAndLocalData:
            return LocalizedString.noNetworkAndLocalDataError.localized
        }
    }
}
