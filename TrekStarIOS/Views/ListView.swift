//
//  ListView.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 10/2/24.
//

import Foundation
import SwiftUI

struct ListView: View {
    @Binding var lists: [ItemList]
    @State private var isPresentingCreateList = false // State to present CreateListView

    @Binding var inventory: [Item] // Bind the inventory to allow selecting items

    @State private var listToEdit: ItemList? = nil
    
    var body: some View {
        NavigationView {
            List {
                if lists.isEmpty {
                    Text("No lists created yet.")
                } else {
                    ForEach(lists.indices, id: \.self) { index in
                        let list = lists[index]
                        Section(header: HStack {
                            Text(list.name)
                            Spacer()
                            Button("Edit") {
                                listToEdit = list // Set the list to edit
                            }
                        }) {
                            ForEach(list.items.indices, id: \.self) { itemIndex in
                                let item = list.items[itemIndex]
                                Text("\(item.name) - \(formattedWeight(item.weight))kg")
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Lists")
            .toolbar {
                Button("Add List") {
                    isPresentingCreateList = true
                }
            }
            .sheet(isPresented: $isPresentingCreateList) {
                CreateListView(inventory: $inventory, lists: $lists) // Present CreateListView
            }
            .sheet(item: $listToEdit) { list in
                if let index = lists.firstIndex(where: { $0.id == list.id }) {
                    EditListView(list: $lists[index], inventory: $inventory) // Pass the list as Binding
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
