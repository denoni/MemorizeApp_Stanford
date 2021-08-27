//
//  Color+DarkSensitive.swift
//  Memorize
//
//  Created by Gabriel on 8/18/21.
//

import SwiftUI

extension Color {
    static let darkSensitive = DarkSensitive()
}

struct DarkSensitive {
    let white = Color("WhiteDarkSensitiveColor")
    let black = Color("BlackDarkSensitiveColor")
}
