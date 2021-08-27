//
//  Array+(with)SingleElement.swift
//  Memorize
//
//  Created by Gabriel on 8/16/21.
//

import Foundation

extension Array {
    //If array has only one element -> return it, else -> return false
    var only: Element? {
        count == 1 ? first : nil
    }
}
