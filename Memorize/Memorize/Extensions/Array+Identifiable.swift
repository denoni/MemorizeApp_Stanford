//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Gabriel on 8/15/21.
//

import Foundation

// This extension is used so we can create an index for
// the elements in an array without needing to duplicate
// the function firstIndex(matching:) in different files.
extension Array where Element: Identifiable {
    //self = the array that the function was called on
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
