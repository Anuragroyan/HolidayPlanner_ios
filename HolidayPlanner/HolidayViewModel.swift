//
//  HolidayViewModel.swift
//  HolidayPlanner
//
//  Created by Dungeon_master on 09/08/25.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class HolidayViewModel: ObservableObject {
    @Published var holidays = [Holiday]()
    @Published var searchQuery = ""
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    init() {
        fetchHolidays()
    }
    
    func fetchHolidays() {
        listenerRegistration = db.collection("Holidayes").addSnapshotListener { [weak self] snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No documents or error: \(error?.localizedDescription ?? "")")
                return
            }
            self?.holidays = documents.compactMap { try? $0.data(as: Holiday.self) }
        }
    }
    
    func addHoliday(_ holiday: Holiday) {
        do {
            _ = try db.collection("Holidayes").addDocument(from: holiday)
        } catch {
            print("Error adding holiday: \(error.localizedDescription)")
        }
    }
    
    func updateHoliday(_ holiday: Holiday) {
        guard let id = holiday.id else { return }
        do {
            try db.collection("Holidayes").document(id).setData(from: holiday)
        } catch {
            print("Error updating holiday: \(error.localizedDescription)")
        }
    }
    
    func deleteHoliday(_ holiday: Holiday) {
        guard let id = holiday.id else { return }
        db.collection("Holidayes").document(id).delete { error in
            if let error = error {
                print("Error deleting holiday: \(error.localizedDescription)")
            }
        }
    }
    
    // Filter holidays by search query
    var filteredHolidays: [Holiday] {
        if searchQuery.isEmpty {
            return holidays
        }
        return holidays.filter {
            $0.title.localizedCaseInsensitiveContains(searchQuery) ||
            $0.location.localizedCaseInsensitiveContains(searchQuery) ||
            $0.holidayName.localizedCaseInsensitiveContains(searchQuery)
        }
    }
    
    deinit {
        listenerRegistration?.remove()
    }
}
