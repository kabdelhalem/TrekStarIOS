//
//  Items.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 10/2/24.
//

import Foundation

struct Item: Identifiable, Equatable {
    var id = UUID() // Add a unique identifier
    var name: String
    var category: String
    var weight: Double
}

struct ItemList: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var items: [Item]
    
    var totalWeight: Double {
        return items.reduce(into: 0) { $0 + ($1.weight ) }
    }
}

enum WeightUnit: String, CaseIterable {
    case kg = "kg"
    case lb = "lb"
    
    func convert(weight: Double, to targetUnit: WeightUnit) -> Double {
        if self == targetUnit {
            return weight
        } else {
            switch targetUnit {
            case .kg:
                return weight / 2.20462
            case .lb:
                return weight * 2.20462
            }
        }
    }
}
