//
//  HolidayFormView.swift
//  HolidayPlanner
//
//  Created by Dungeon_master on 09/08/25.
//

import SwiftUI

struct HolidayFormView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: HolidayViewModel
    @Binding var holidayToEdit: Holiday?
    
    @State private var title = ""
    @State private var location = ""
    @State private var holidayName = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var cardHexColor = "#4A90E2" // default blue
    
    var isEditing: Bool {
        holidayToEdit != nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Holiday Info")) {
                    TextField("Title", text: $title)
                    TextField("Location", text: $location)
                    TextField("Holiday Name", text: $holidayName)
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                }
                
                Section(header: Text("Card Color (Hex)")) {
                    TextField("#HexColor", text: $cardHexColor)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
            .navigationTitle(isEditing ? "Edit Holiday" : "Add Holiday")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button(isEditing ? "Update" : "Add") {
                    saveHoliday()
                }
                .disabled(title.isEmpty || location.isEmpty || holidayName.isEmpty)
            )
            .onAppear {
                if let holiday = holidayToEdit {
                    title = holiday.title
                    location = holiday.location
                    holidayName = holiday.holidayName
                    startDate = holiday.startDate
                    endDate = holiday.endDate
                    cardHexColor = holiday.cardHexColor
                }
            }
        }
    }
    
    private func saveHoliday() {
        let newHoliday = Holiday(
            id: holidayToEdit?.id,
            title: title,
            location: location,
            holidayName: holidayName,
            startDate: startDate,
            endDate: endDate,
            cardHexColor: cardHexColor
        )
        
        if isEditing {
            viewModel.updateHoliday(newHoliday)
        } else {
            viewModel.addHoliday(newHoliday)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}
