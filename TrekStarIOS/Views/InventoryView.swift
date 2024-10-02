//
//  Inventory.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 10/2/24.
//

import Foundation
import SwiftUI

struct InventoryView: View {
    @Binding var lists: [ItemList]
    @Binding var inventory: [Item]
    @State private var isPresentingAddItem = false
    @State private var itemToEdit: Item? = nil

    var body: some View {
        NavigationView {
            List {
                let filteredCategories = Category.allCases.filter { category in
                    inventory.contains(where: { $0.category == category.rawValue })
                }
                
                ForEach(filteredCategories, id: \.self) { category in
                    Section(header: Text(category.rawValue)) {
                        let categoryItems = inventory.filter { $0.category == category.rawValue }
                        ForEach(categoryItems.indices, id: \.self) { index in
                            let item = $inventory[index] // Use Binding for each item
                            HStack {
                                Text("\(item.wrappedValue.name) - \(formattedWeight(item.wrappedValue.weight))kg") // Access item using wrappedValue
                                Spacer()
                                Button("Edit") {
                                    itemToEdit = item.wrappedValue // Set the selected item to edit
                                }
                            }
                        }
                        .onDelete(perform: { indexSet in
                            deleteItems(at: indexSet, in: category)
                        })
                    }
                }
            }
            .navigationTitle("Inventory")
            .toolbar {
                Button("Add Item") {
                    isPresentingAddItem = true
                }
            }
            .sheet(isPresented: $isPresentingAddItem) {
                AddItemView(inventory: $inventory)
            }
            .sheet(item: $itemToEdit) { item in
                if let index = inventory.firstIndex(where: { $0.id == item.id }) {
                    EditItemView(item: $inventory[index], inventory: $inventory) // Use Binding
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

    private func deleteItems(at offsets: IndexSet, in category: Category) {
        let categoryItems = inventory.filter { $0.category == category.rawValue }
        for offset in offsets {
            if let index = inventory.firstIndex(of: categoryItems[offset]) {
                inventory.remove(at: index)
            }
        }
    }
}
