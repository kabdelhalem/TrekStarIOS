//
//  ContentView.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 9/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var lists: [ItemList] = []
    @State private var inventory: [Item] = []
    
    var body: some View {
        TabView {
            InventoryView(lists: $lists, inventory: $inventory)
                .tabItem {
                    Label("Inventory", systemImage: "archivebox")
                }
            
            ListView(lists: $lists, inventory: $inventory)
                .tabItem {
                    Label("Lists", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    ContentView()
}
