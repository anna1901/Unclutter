//
//  Color.swift
//  Unclutter
//
//  Created by Anna Olak on 06/02/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let background = Color("Background")
    let accent = Color("AccentColor")
    let textfieldBackground = Color("TextfieldBackground")
}
