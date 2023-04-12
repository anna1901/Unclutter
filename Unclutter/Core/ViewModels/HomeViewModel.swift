//
//  HomeViewModel.swift
//  Unclutter
//
//  Created by Anna Olak on 20/02/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var categories: [CategoryModel] = []
    @Published var itemsCount: Int = 0
    @Published var soldItemsPrice: Double = 0
    
    @Published var nameInvalid = false
    @Published var categoryInvalid = false
    
    
    private let dataService: CategoriesDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(preview: Bool = false) {
        if preview {
            dataService = CategoriesDataService(persistence: PersistenceController.preview)
        } else {
            dataService = CategoriesDataService(persistence: PersistenceController.shared)
        }
        addSubscribers()
    }
    
    func addItem(name: String, price: String, categoryName: String, completion: () -> Void) {
        guard !name.isEmpty, !categoryName.isEmpty else {
            categoryInvalid = categoryName.isEmpty
            nameInvalid = name.isEmpty
            return
        }
        dataService.addItem(name: name, price: price, categoryName: categoryName)
        completion()
    }
    
    func addCategory(name: String) {
        dataService.addCategory(name: name)
    }
    
    func refresh() {
        dataService.refresh()
    }
    
    func addItemViewDismissed() {
        categoryInvalid = false
        nameInvalid = false
    }
    
    func removeCategory(atOffsets offsets: IndexSet) {
        offsets.map { categories[$0] }.forEach({
            dataService.deleteCategory(with: $0.name)
            print("Deleted category: \($0)")
        })
    }
        
    private func addSubscribers() {
        dataService.$categories
            .map { categories -> [CategoryModel] in
                categories.compactMap({ categoryEntity -> CategoryModel? in
                    guard let createdAt = categoryEntity.createdAt, let name = categoryEntity.name, let items = categoryEntity.items?.allObjects as? [Item] else { return nil }
                    return CategoryModel(createdAt: createdAt, name: name, itemsCount: items.count, itemsValue: items.reduce(0, { $0 + $1.price}))
                })
            }
            .sink { [weak self] categories in
                self?.categories = categories
                self?.itemsCount = categories.reduce(0, { $0 + $1.itemsCount})
                self?.soldItemsPrice = categories.reduce(0, { $0 + $1.itemsValue})
            }
            .store(in: &cancellables)
    }
}
