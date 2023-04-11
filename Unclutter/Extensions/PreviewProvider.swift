//
//  PreviewProvider.swift
//  Unclutter
//
//  Created by Anna Olak on 11/04/2023.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let homeVM = HomeViewModel(preview: true)
    let categoryVM = CategoryViewModel(category: CategoryModel(createdAt: Date(), name: "Category 2", itemsCount: 10, itemsValue: 0), preview: true)
    
    let categories = [
        CategoryModel(createdAt: Date(), name: "Category 1", itemsCount: 0, itemsValue: 0),
        CategoryModel(createdAt: Date(), name: "Category 2", itemsCount: 10, itemsValue: 0),
        CategoryModel(createdAt: Date(), name: "Category 3", itemsCount: 100, itemsValue: 0)
    ]
}
