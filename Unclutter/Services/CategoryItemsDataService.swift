//
//  ItemsDataService.swift
//  Unclutter
//
//  Created by Anna Olak on 20/02/2023.
//

import Foundation
import CoreData

class CategoryItemsDataService: ObservableObject {
    @Published var items: [Item] = []
    private let persistenceController = PersistenceController.shared
    
    init(category: CategoryModel) {
        loadItems(for: category)
    }
    
    private func loadItems(for category: CategoryModel) {
        let request = NSFetchRequest<Item>(entityName: "Item")
        let predicate = NSPredicate(format: "category.name = %@", category.name)
        request.predicate = predicate
        
        do {
            items = try persistenceController.container.viewContext.fetch(request)
            print("Loaded items for category \(category.name): \(items)")
        } catch {
            print("Failed to fetch categories: \(error)")
        }
    }
}
