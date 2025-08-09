//
//  ContentView.swift
//  HolidayPlanner
//
//  Created by Dungeon_master on 09/08/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HolidayViewModel()
    
    @State private var showForm = false
    @State private var editingHoliday: Holiday? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search holidays...", text: $viewModel.searchQuery)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding()
                
                List {
                    ForEach(viewModel.filteredHolidays) { holiday in
                        HolidayCardView(holiday: holiday)
                            .onTapGesture {
                                editingHoliday = holiday
                                showForm = true
                            }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let holiday = viewModel.filteredHolidays[index]
                            viewModel.deleteHoliday(holiday)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Holiday Planner")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editingHoliday = nil
                        showForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showForm) {
                HolidayFormView(viewModel: viewModel, holidayToEdit: $editingHoliday)
            }
        }
    }
}

struct HolidayCardView: View {
    let holiday: Holiday
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(holiday.title)
                .font(.headline)
            Text(holiday.holidayName)
                .font(.subheadline)
            Text(holiday.location)
                .font(.subheadline)
            Text("From \(formattedDate(holiday.startDate)) to \(formattedDate(holiday.endDate))")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(hex: holiday.cardHexColor) ?? Color.blue.opacity(0.7))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


