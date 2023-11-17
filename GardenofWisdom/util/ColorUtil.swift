//
//  ColorUtil.swift
//  GardenofWisdom
//
//  Created by Miami Jaboori on 2024-01-05.
//

import SwiftUI

extension Color {
    func toString() -> String {
        if #available(iOS 15.0, *) {
            // If running on iOS 15 or later, you can use the description property
            return description
        } else {
            // For earlier versions, convert RGB components to a string
            let uiColor = UIColor(self)
            return uiColor.description
        }
    }
}


