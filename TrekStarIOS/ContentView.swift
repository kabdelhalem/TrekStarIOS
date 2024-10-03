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
    @State private var selectedUnit: WeightUnit = .lb
    
    var body: some View {
        TabView {
            InventoryView(lists: $lists, inventory: $inventory, selectedUnit: $selectedUnit)
                .tabItem {
                    Label("Inventory", systemImage: "archivebox")
                }
            
            ListView(lists: $lists, inventory: $inventory, selectedUnit: $selectedUnit)
                .tabItem {
                    Label("Lists", systemImage: "list.bullet")
                }
        }
        .accentColor(Color.lightGold)
        .onAppear {
            UITabBar.appearance().barTintColor = UIColor(Color.darkGreen)
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.forestGreen)
        }
    }
}

#Preview {
    ContentView()
}
