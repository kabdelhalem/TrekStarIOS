//
//  EditListView.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 10/2/24.
//

import Foundation
import SwiftUI

struct EditListView: View {
    @Binding var list: ItemList // Binding to the list we are editing
    @Binding var inventory: [Item] // Access to the full inventory

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("List Name")) {
                    TextField("List Name", text: $list.name)
                }

                Section(header: Text("Items in List")) {
                    ForEach(list.items.indices, id: \.self) { index in
                        let item = list.items[index]
                        HStack {
                            Text("\(item.name) - \(formattedWeight(item.weight))kg")
                            Spacer()
                            Button("Remove") {
                                list.items.remove(at: index) // Remove item from the list
                            }
                        }
                    }
                }

                Section(header: Text("Add Items from Inventory")) {
                    ForEach(inventory.indices, id: \.self) { index in
                        let item = inventory[index]
                        if !list.items.contains(where: { $0.id == item.id }) {
                            HStack {
                                Text("\(item.name) - \(formattedWeight(item.weight))kg")
                                Spacer()
                                Button("Add") {
                                    list.items.append(item) // Add item from inventory to the list
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        presentationMode.wrappedValue.dismiss() // Save changes and close
                    }
                }
            }
        }
    }

    private func formattedWeight(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
}
