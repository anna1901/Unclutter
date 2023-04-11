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
    private let persistenceController: PersistenceController
    private var category: CategoryModel
    
    init(category: CategoryModel, persistence: PersistenceController) {
        self.persistenceController = persistence
        self.category = category
        loadItems(for: category)
    }
    
    func deleteItem(with uuid: UUID) {
        let context = persistenceController.container.viewContext
        let request = NSFetchRequest<Item>(entityName: "Item")
        let predicate = NSPredicate(format: "uuid = %@", uuid.uuidString)
        request.predicate = predicate
        do {
            items = try context.fetch(request)
            print("Loaded items: \(items)")
            items.forEach(context.delete(_:))
            try context.save()
            loadItems(for: category)
        } catch {
            print("Failed to delete items: \(error)")
        }
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
