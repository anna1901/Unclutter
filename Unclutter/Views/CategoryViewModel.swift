//
//  CategoryViewModel.swift
//  Unclutter
//
//  Created by Anna Olak on 26/01/2023.
//

import Foundation
import CoreData
import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var items: [Item] = []
    
    private let context: NSManagedObjectContext
    private let name: String
    
    init(name: String, context: NSManagedObjectContext) {
        self.context = context
        self.name = name
        fetchItems()
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(context.delete)
            
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                print("Failed to delete items: \(nsError)")
            }
            fetchItems()
        }
    }
    
    private func fetchItems() {
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        request.predicate = NSPredicate(format: "category.name == %@", name)
        do {
            try items = context.fetch(request)
        } catch {
            print("Failed to fetch items for category: \(name)")
        }
    }
}
