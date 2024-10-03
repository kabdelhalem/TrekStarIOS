//
//  EditInventoryView.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 10/2/24.
//

import Foundation
import SwiftUI

struct EditItemView: View {
    @Binding var item: Item
    @Binding var inventory: [Item]
    @Binding var selectedUnit: WeightUnit

    @Environment(\.presentationMode) var presentationMode

    var categories = Category.allCases
    
    @State private var selectedCategory: Category = .clothing

    var body: some View {
        Form {
            Section(header: Text("Item Name")
                        .foregroundColor(.lightGold)) {
                TextField("Item Name", text: $item.name)
                    .foregroundColor(.lightGold)
            }
            .listRowBackground(Color.darkGreen)

            Section(header: Text("Category")
                        .foregroundColor(.lightGold)) {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category.rawValue)
                            .foregroundColor(.forestGreen)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            .listRowBackground(Color.darkGreen)

            Section(header: Text("Weight (\(selectedUnit.rawValue))")
                        .foregroundColor(.lightGold)) {
                TextField("Weight", value: $item.weight, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                    .foregroundColor(.lightGold)
            }
            .listRowBackground(Color.darkGreen)

            Button(action: {
                if let index = inventory.firstIndex(where: { $0.id == item.id }) {
                    inventory[index].name = item.name
                    inventory[index].weight = item.weight
                    inventory[index].category = selectedCategory.rawValue
                }
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save Changes")
                    .foregroundColor(.darkGreen)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.lightGold)
                    .cornerRadius(8)
            }
            .listRowBackground(Color.darkGreen)
        }
        .navigationTitle("Edit Item")
        .background(Color.darkGreen)
        .scrollContentBackground(.hidden)
        .onAppear {
            if let currentCategory = Category(rawValue: item.category) {
                selectedCategory = currentCategory
            }
        }
    }
}
