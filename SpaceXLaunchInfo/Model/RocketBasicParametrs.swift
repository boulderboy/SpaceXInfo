//
//  RocketBasicParametrs.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 29.11.2022.
//

import Foundation

struct RocketBasicParametrs {
    var heightInMeters: Double
    var heightInFeets: Double
    var diametrInMeters: Double
    var diametrInFeets: Double
    var massInKg: Int
    var massInLb: Int
    var loadInKg: Int
    var loadInLb: Int
}

extension RocketBasicParametrs {
    func toElements(isHeightInMeters: Bool, isDiametrMeters: Bool, isMassKg: Bool, isLoadInKg: Bool) -> [BasicParametrElement] {

            var result = [BasicParametrElement]()

            let heightValue = isHeightInMeters ? heightInMeters : heightInFeets
            var unitType = isHeightInMeters ? "m" : "ft"
            let height = BasicParametrElement(value: String(describing: heightValue), description: "Высота", unitType: unitType)
            result.append(height)

            let diametrValue = isDiametrMeters ? diametrInMeters : diametrInFeets
            unitType = isDiametrMeters ? "m" : "ft"
            let diametr = BasicParametrElement(value: String(describing: diametrValue), description: "Диаметр", unitType: unitType)
            result.append(diametr)

        let massValue = isMassKg ? massInKg.formattedWithSeparator : massInLb.formattedWithSeparator
            unitType = isMassKg ? "kg" : "lb"
            let mass = BasicParametrElement(value: String(describing: massValue), description: "Масса", unitType: unitType)
            result.append(mass)

        let loadValue = isLoadInKg ? loadInKg.formattedWithSeparator : loadInLb.formattedWithSeparator
            unitType = isLoadInKg ? "kg" : "lb"
            let load = BasicParametrElement(value: String(describing: loadValue), description: "Загрузка", unitType: unitType)
            result.append(load)

            return result
        }
}

extension
 Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

extension
 Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}
