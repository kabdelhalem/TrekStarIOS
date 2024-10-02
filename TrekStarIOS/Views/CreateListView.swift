//
//  CreateListView.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 10/2/24.
//

import Foundation
import SwiftUI

struct CreateListView: View {
    @Binding var inventory: [Item]
    @Binding var lists: [ItemList]

    @State private var selectedItems: [Item] = []
    @State private var listName: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("List Name")) {
                    TextField("Enter list name", text: $listName)
                }

                Section(header: Text("Select Items")) {
                    List {
                        ForEach(inventory.indices, id: \.self) { index in
                            let item = inventory[index]
                            MultipleSelectionRow(item: item, isSelected: selectedItems.contains(where: { $0.name == item.name })) {
                                if selectedItems.contains(where: { $0.name == item.name }) {
                                    selectedItems.removeAll(where: { $0.name == item.name })
                                } else {
                                    selectedItems.append(item)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Create New List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        if !listName.isEmpty {
                            let newList = ItemList(name: listName, items: selectedItems)
                            lists.append(newList)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}
