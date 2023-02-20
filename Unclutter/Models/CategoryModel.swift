//
//  Category.swift
//  Unclutter
//
//  Created by Anna Olak on 20/02/2023.
//

import Foundation

struct CategoryModel: Identifiable {
    let id = UUID().uuidString
    let createdAt: Date
    let name: String
    let itemsCount: Int
    let itemsValue: Double
}
