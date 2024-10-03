//
//  EditListView.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 10/2/24.
//

import Foundation
import SwiftUI

struct EditListView: View {
    @Binding var list: ItemList
    @Binding var inventory: [Item]

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("List Name")
                            .foregroundColor(.lightGold)) {
                    TextField("List Name", text: $list.name)
                        .foregroundColor(.lightGold)
                }
                .listRowBackground(Color.darkGreen)

                Section(header: Text("Select Items")
                            .foregroundColor(.lightGold)) {
                    List {
                        ForEach(inventory.indices, id: \.self) { index in
                            let item = inventory[index]
                            MultipleSelectionRow(item: item, isSelected: list.items.contains(where: { $0.id == item.id })) {
                                if list.items.contains(where: { $0.id == item.id }) {
                                    list.items.removeAll(where: { $0.id == item.id })
                                } else {
                                    list.items.append(item)
                                }
                            }
                            .listRowBackground(Color.forestGreen) // Set row background color
                        }
                    }
                }
                .listRowBackground(Color.darkGreen)

                Button(action: {
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
            .background(Color.darkGreen)
            .scrollContentBackground(.hidden)
            .navigationTitle("Edit List")
            .foregroundColor(.lightGold)
        }
    }

    private func formattedWeight(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.2f", weight)
        }
    }
}
