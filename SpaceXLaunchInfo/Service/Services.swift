//
//  Services.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 30.11.2022.
//

import Foundation

final class Services {
    
    static func dateFormat(date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dateValue = dateFormatter.date(from: date) else { return nil }
        if #available(iOS 15.0, *) {
            let formattedDate = dateValue.formatted(
                Date.FormatStyle()
                    .day(.twoDigits)
                    .month(.wide)
                    .year(.defaultDigits)
                    .locale(Locale(identifier: "ru_RU"))
            )
            return formattedDate
        } else {
            // Fallback on earlier versions
        }
        return nil
    }
}
