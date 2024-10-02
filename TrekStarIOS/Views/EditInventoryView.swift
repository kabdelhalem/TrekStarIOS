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
    @Binding var inventory: [Item] // To update the inventory with the changes

    @Environment(\.presentationMode) var presentationMode

    var categories = Category.allCases

    var body: some View {
        NavigationView {
            Form {
                TextField("Item Name", text: $item.name)

                Picker("Category", selection: $item.category) {
                    ForEach(categories, id: \.self) { category in
                        Text(category.rawValue).tag(category.rawValue)
                    }
                }

                TextField("Weight (kg)", value: $item.weight, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Edit Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let index = inventory.firstIndex(where: { $0.id == item.id }) {
                            inventory[index] = item // Update the inventory with the edited item
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
