//
//  LocalizedString.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//
// TODO: Draft

import Foundation

enum LocalizedString: String {
    // MARK: - Splash screen

    case appName = "Spectator"
    case countryName = "Ukraine"
    case victory = "Victory"

    // MARK: - Alert elements

    case errorTitle = "⚠️"
    case criticalErrorTitle = "Critical error ⛔️"
    case okButtonText = "OK"
    case retryButtonText = "Retry"

    // MARK: - Errors

    case noInternetConnectionError = "No internet connection. Data loaded from cache."
    case invalidURLError = "Invalid URL. Data loaded from cache."
    case noDataError = "No data received from server. Data loaded from cache."
    case decodingError = "Invalid data format received from server"
    case noNetworkAndLocalDataError = "No network or cached data available."

    // MARK: - Tabs

    case lossesTab = "Losses"
    case equipmentTab = "Equipment"
    case moreTab = "More"

    // MARK: - Screen Titles

    case equipmentTitle = "Equipment losses"
    case moreTitle = "Spectator settings"

    // MARK: - Latest losses screen

    case daysOfWar = "days of war"
    case lossesInfo = "Estimated losses of the russian army"
    case personnelLoss = "Personnels"
    case aircraftLoss = "Aircrafts"
    case helicopterLoss = "Helicopters"
    case tankLoss = "Tanks"
    case armouredPersonnelCarrierLoss = "Armoured Carriers"
    case fieldArtilleryLoss = "Field Artilleries"
    case multipleRocketLauncherLoss = "Rocket Launchers"
    case droneLoss = "Drones"
    case navalShipLoss = "Naval Ships"
    case antiAircraftWarfareLoss = "Anti-Aircrafts"
    case specialEquipmentLoss = "Special Equipments"
    case vehiclesAndFuelTanksLoss = "Vehicles"
    case cruiseMissilesLoss = "Cruise Missiles"

    // MARK: - More screen

    case developedByText = "Developed by Beavean"
    case donateToArmyText = "Donate to Army"
}

extension LocalizedString {
    var localized: String {
        return rawValue
    }
}
