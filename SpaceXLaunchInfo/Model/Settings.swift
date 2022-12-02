//
//  Settings.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 02.12.2022.
//

import Foundation

final class Settings {
    var heightInMeters: Bool = true
    var diametrInMeters: Bool = true
    var massInKg: Bool = true
    var loadInKg: Bool = true
    
    static let shared = Settings()
}
