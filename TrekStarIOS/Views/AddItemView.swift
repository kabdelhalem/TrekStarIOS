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
    @State private var selectedCategory: Category = .clothing
    @State private var weight = ""
    @Binding var selectedUnit: WeightUnit
    
    var categories = Category.allCases
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("Item Name")
                        .foregroundColor(.lightGold)) {
                TextField("Item Name", text: $name)
                    .foregroundColor(.lightGold)
            }
            .listRowBackground(Color.darkGreen)
            
            Section(header: Text("Category")
                        .foregroundColor(.lightGold)) {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category.rawValue)
                            .foregroundColor(.lightGold)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            .listRowBackground(Color.darkGreen)
            
            Section(header: Text("Weight (\(selectedUnit.rawValue))")
                        .foregroundColor(.lightGold)) {
                TextField("Weight", text: $weight)
                    .keyboardType(.decimalPad)
                    .foregroundColor(.lightGold)
            }
            .listRowBackground(Color.darkGreen)
            
            Button(action: {
                if let weightValue = Double(weight) {
                    let newItem = Item(name: name, category: selectedCategory.rawValue, weight: weightValue)
                    inventory.append(newItem)
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Add Item")
                    .foregroundColor(.darkGreen)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.lightGold)
                    .cornerRadius(8)
            }
            .listRowBackground(Color.darkGreen)
        }
        .navigationTitle("Add New Item")
        .background(Color.darkGreen)
        .scrollContentBackground(.hidden)
    }
}
