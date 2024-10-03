//
//  AddItemView.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 10/2/24.
//

import Foundation
import SwiftUI

struct AddItemView: View {
    @Binding var inventory: [Item]
    
    @State private var name = ""
    @State private var selectedCategory = Category.clothing.rawValue
    @State private var weight = ""
    @Binding var selectedUnit: WeightUnit
    
    var categories = Category.allCases
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            TextField("Item Name", text: $name)
            
            Picker("Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category.rawValue).tag(category.rawValue)
                }
            }
            
            TextField("Weight (\(selectedUnit))", text: $weight)
                .keyboardType(.decimalPad)
            
            Button("Add Item") {
                if let weightValue = Double(weight) {
                    let newItem = Item(name: name, category: selectedCategory, weight: weightValue)
                    inventory.append(newItem)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle("Add New Item")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
