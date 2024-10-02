//
//  MultipleSelectionRow.swift
//  TrekStarIOS
//
//  Created by Kareem Abdelhalem on 10/2/24.
//

import Foundation
import SwiftUI

struct MultipleSelectionRow: View {
    var item: Item
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
}
