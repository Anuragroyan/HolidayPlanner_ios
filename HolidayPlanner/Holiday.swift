//
//  Holiday.swift
//  HolidayPlanner
//
//  Created by Dungeon_master on 09/08/25.
//
import Foundation
import FirebaseFirestoreSwift

struct Holiday: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var location: String
    var holidayName: String
    var startDate: Date
    var endDate: Date
    var cardHexColor: String
}

