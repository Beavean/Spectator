//
//  EquipmentType.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

enum EquipmentType: String, Codable, CaseIterable {
    case all = "All types"
    case aircrafts = "Aircrafts"
    case antiAircraftWarfareSystems = "Anti-aircraft Warfare Systems"
    case armouredPersonnelCarriers = "Armoured Personnel Carriers"
    case artillerySystems = "Artillery Systems"
    case helicopters = "Helicopters"
    case multipleRocketLaunchers = "Multiple Rocket Launchers"
    case specialEquipment = "Special Equipment"
    case tanks = "Tanks"
    case unmannedAerialVehicles = "Unmanned Aerial Vehicles"
    case vehicleAndFuelTank = "Vehicle and Fuel Tank"
    case warshipsBoats = "Warships, Boats"

    var image: UIImage? {
        Constants.SystemImage.squarePlaceholder.image
    }
}
