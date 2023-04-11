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
    
    func addItem(name: String, price: String, categoryName: String) {
        dataService.addItem(name: name, price: price, categoryName: categoryName)
    }
    
    func refresh() {
        dataService.refresh()
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
