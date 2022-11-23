//
//  Rocket.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 22.11.2022.
//

import Foundation

struct Rocket: Decodable {
    let height: Diameter
    let diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name: String
    let type: String
    let active: Bool
    let stages: Int
    let boosters: Int
    let costPerLaunch: Int
    let successRatePct: Int
    let firstFlight: String
    let country: String
    let company: String
    let wikipedia: String
    let rocketDescription: String?
    let id: String
}

struct Diameter: Decodable {
    let meters: Double?
    let feet: Double?
}

struct Engines: Decodable {
    let isp: ISP
    let thrustSeaLevel: Thrust
    let thrustVacuum: Thrust
    let number: Int
    let type, version: String
    let layout: String?
    let engineLossMax: Int?
    let propellant1: String
    let propellant2: String
    let thrustToWeight: Double
}

struct ISP: Decodable {
    let seaLevel: Int
    let vacuum: Int
}

struct Thrust: Decodable {
    let kN: Int
    let lbf: Int
}

struct FirstStage: Decodable {
    let thrustSeaLevel: Thrust
    let thrustVacuum: Thrust
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?
}

struct LandingLegs: Decodable {
    let number: Int
    let material: String?
}

struct Mass: Decodable {
    let kg: Int
    let lb: Int
}

struct PayloadWeight: Decodable {
    let id: String
    let name: String
    let kg: Int
    let lb: Int
}

struct SecondStage: Decodable {
    let thrust: Thrust
    let payloads: Payloads
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?
}

struct Payloads: Decodable {
    let compositeFairing: CompositeFairing
    let option1: String
}

struct CompositeFairing: Decodable {
    let height: Diameter
    let diameter: Diameter
}

