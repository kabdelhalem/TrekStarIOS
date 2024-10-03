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
    @State private var isPresentingSettings = false
    @Binding var selectedUnit: WeightUnit

    var body: some View {
        NavigationView {
            List {
                let filteredCategories = Category.allCases.filter { category in
                    inventory.contains(where: { $0.category == category.rawValue })
                }
                
                ForEach(filteredCategories, id: \.self) { category in
                    Section(header: Text(category.rawValue)) {
                        let categoryItems = inventory.filter { $0.category == category.rawValue } // Filter items by category
                        ForEach(categoryItems.indices, id: \.self) { index in
                            let item = categoryItems[index] // Get the current item
                            let itemName = item.name // Extract values into variables
                            let itemWeight = formattedWeight(item.weight, currentUnit: .lb, targetUnit: selectedUnit) // Format weight
                            let itemCategory = item.category
                            HStack {
                                Text("\(itemName) - \(itemWeight) \(selectedUnit.rawValue)")
                                Spacer()
                                Button("Edit") {
                                    if let inventoryIndex = inventory.firstIndex(where: { $0.id == item.id }) {
                                        itemToEdit = inventory[inventoryIndex] // Set the correct item to edit
                                        // Print item details
                                        print("Editing item: \(itemName), Weight: \(itemWeight), Category: \(itemCategory)")
                                    }
                                }
                            }
                        }
                        .onDelete(perform: { indexSet in
                            deleteItems(at: indexSet, in: category)
                        })
                    }
                    .listRowBackground(Color.forestGreen)
                }
            }
            .background(Color.darkGreen)
            .scrollContentBackground(.hidden)
            .navigationTitle("Inventory")
            .foregroundColor(.lightGold)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresentingSettings = true
                    }) {
                        Image(systemName: "gear")
                            .foregroundColor(.lightGold)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Item") {
                        isPresentingAddItem = true
                    }
                    .foregroundColor(.lightGold)
                }
            }
            .sheet(isPresented: $isPresentingAddItem) {
                AddItemView(inventory: $inventory, selectedUnit: $selectedUnit)
            }
            .sheet(isPresented: $isPresentingSettings) {
                SettingsView(selectedUnit: $selectedUnit)
            }
            .sheet(item: $itemToEdit) { item in
                if let index = inventory.firstIndex(where: { $0.id == item.id }) {
                    EditItemView(item: $inventory[index], inventory: $inventory, selectedUnit: $selectedUnit) // Use Binding
                }
            }
        }
    }
    
    private func formattedWeight(_ weight: Double, currentUnit: WeightUnit, targetUnit: WeightUnit) -> String {
        let convertedWeight = currentUnit.convert(weight: weight, to: targetUnit)
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", convertedWeight)
        } else {
            return String(format: "%.2f", convertedWeight)
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
