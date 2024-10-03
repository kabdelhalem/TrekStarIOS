//
//  SettingsView.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 10/3/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Binding var selectedUnit: WeightUnit // Binding to the selected unit

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Weight Unit")) {
                    Picker("Select Unit", selection: $selectedUnit) {
                        ForEach(WeightUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue.capitalized).tag(unit)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle()) // Segmented control for unit selection
                }
            }
            .navigationTitle("Settings")
        }
    }
}
