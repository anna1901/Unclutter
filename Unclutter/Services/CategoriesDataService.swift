//
//  UnclutterDataService.swift
//  Unclutter
//
//  Created by Anna Olak on 20/02/2023.
//

import Foundation
import CoreData

class CategoriesDataService: ObservableObject {
    @Published var categories: [Category] = []
    private let persistenceController: PersistenceController
    
    init(persistence: PersistenceController) {
        self.persistenceController = persistence
        loadCategories()
    }
    
    func refresh() {
        loadCategories()
    }
    
    func addItem(name: String, price: String, categoryName: String) {
        let context = persistenceController.container.viewContext
        context.perform {
            let newItem = Item(context: context)
            newItem.name = name
            newItem.price = Double(price) ?? 0
            newItem.timestamp = Date()
            newItem.uuid = UUID()
            
            if let selectedCategory = self.categories.first(where: { $0.name == categoryName }) {
                newItem.category = selectedCategory
            } else {
                let newCategory = Category(context: context)
                newCategory.name = categoryName.isEmpty ? "New category" : categoryName
                newCategory.createdAt = Date()
                newItem.category = newCategory
            }
            
            do {
                try context.save()
                self.loadCategories()
            } catch {
                print("Error when adding new item: \(error)")
            }
        }
    }
    
    private func loadCategories() {
        let request = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            categories = try persistenceController.container.viewContext.fetch(request)
        } catch {
            print("Failed to fetch categories: \(error)")
        }
    }
}
