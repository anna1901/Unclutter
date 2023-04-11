//
//  ItemModel.swift
//  Unclutter
//
//  Created by Anna Olak on 20/02/2023.
//

import Foundation

struct ItemModel: Identifiable {
    let id: UUID
    let name: String
    let price: Double
    let soldAt: Date
}
