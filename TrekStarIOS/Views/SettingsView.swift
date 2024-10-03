//
//  SettingsView.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 10/3/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Binding var selectedUnit: WeightUnit

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Weight Unit")
                            .foregroundColor(.lightGold)
                        ) {
                    Picker("Select Unit", selection: $selectedUnit) {
                        ForEach(WeightUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                                .foregroundColor(.forestGreen)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.darkGreen)
                    .cornerRadius(8)
                }
                .listRowBackground(Color.darkGreen)
            }
            .background(Color.darkGreen.edgesIgnoringSafeArea(.all))
            .scrollContentBackground(.hidden)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.lightGold)
        }
        .background(Color.darkGreen)
        .foregroundColor(.lightGold)
    }
}
