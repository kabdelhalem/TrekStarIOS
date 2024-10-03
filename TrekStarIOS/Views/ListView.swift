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
    @State private var isPresentingCreateList = false
    @Binding var inventory: [Item]
    @State private var listToEdit: ItemList? = nil
    @Binding var selectedUnit: WeightUnit
    
    var body: some View {
        NavigationView {
            List {
                if lists.isEmpty {
                    Text("No lists created yet.")
                        .foregroundColor(.lightGold)
                        .listRowBackground(Color.darkGreen)
                } else {
                    ForEach(lists.indices, id: \.self) { index in
                        let list = lists[index]
                        Section(header: HStack {
                            Text(list.name)
                                .foregroundColor(.lightGold)
                            Spacer()
                            Button("Edit") {
                                listToEdit = list
                            }
                            .foregroundColor(.lightGold)
                        }) {
                            ForEach(list.items.indices, id: \.self) { itemIndex in
                                let item = list.items[itemIndex]
                                Text("\(item.name) - \(formattedWeight(item.weight)) \(selectedUnit.rawValue)")
                                    .foregroundColor(.lightGold)
                            }
                            .listRowBackground(Color.forestGreen)
                            
                            let totalWeight = list.items.reduce(0.0) { $0 + selectedUnit.convert(weight: $1.weight, to: selectedUnit) }
                            Section {
                                Text("Total Weight: \(String(format: "%.2f", totalWeight)) \(selectedUnit.rawValue)")
                                    .foregroundColor(.lightGold)
                            }
                            .listRowBackground(Color.forestGreen)
                        }
                        .listRowBackground(Color.darkGreen)
                    }
                }
            }
            .background(Color.darkGreen)
            .scrollContentBackground(.hidden)
            .navigationTitle("My Lists")
            .foregroundColor(.lightGold)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add List") {
                        isPresentingCreateList = true
                    }
                    .foregroundColor(.lightGold)
                }
            }
            .sheet(isPresented: $isPresentingCreateList) {
                CreateListView(inventory: $inventory, lists: $lists)
            }
            .sheet(item: $listToEdit) { list in
                if let index = lists.firstIndex(where: { $0.id == list.id }) {
                    EditListView(list: $lists[index], inventory: $inventory)
                }
            }
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
