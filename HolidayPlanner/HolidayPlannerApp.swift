//
//  HolidayPlannerApp.swift
//  HolidayPlanner
//
//  Created by Dungeon_master on 09/08/25.
//

import SwiftUI
import Firebase

@main
struct HolidayPlannerApp: App {
    init() {
           FirebaseApp.configure()
       }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
