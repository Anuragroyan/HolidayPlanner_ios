//
//  Color.swift
//  HolidayPlanner
//
//  Created by Dungeon_master on 09/08/25.
//

import SwiftUI

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let length = hexSanitized.count
        
        let r, g, b, a: UInt64
        switch length {
        case 6: // RGB (24-bit)
            (r, g, b, a) = (rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF, 255)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (rgb >> 24 & 0xFF, rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF)
        default:
            return nil
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
