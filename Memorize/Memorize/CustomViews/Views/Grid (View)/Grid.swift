//
//  Grid.swift
//  Memorize
//
//  Created by Gabriel on 8/15/21.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            buildGridBody(with: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }
    
    private func buildGridBody(with layout: GridLayout) -> some View {
        ForEach(items) { item in
            let index = items.firstIndex(matching: item)!
            viewForItem(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: index))
        }
    }
}

