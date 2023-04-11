//
//  CategoryViewModel.swift
//  Unclutter
//
//  Created by Anna Olak on 26/01/2023.
//

import Foundation
import Combine

class CategoryViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    let categoryName: String
    
    private let category: CategoryModel
    private let dataService: CategoryItemsDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(category: CategoryModel, preview: Bool = false) {
        self.category = category
        categoryName = category.name
        dataService = CategoryItemsDataService(category: category, persistence: preview ? PersistenceController.preview : PersistenceController.shared)
        addSubscribers()
    }
    
    func deleteItems(offsets: IndexSet) {
        offsets.map { items[$0] }.forEach({
            // delete logic
            print("Deleted item: \($0)")
        })
    }
    
    private func addSubscribers() {
        dataService.$items
            .map { items in
                items.compactMap { item -> ItemModel? in
                    guard let name = item.name, let date = item.timestamp else { return nil }
                    return ItemModel(name: name, price: item.price, soldAt: date)
                }
            }
            .sink { [weak self] items in
                self?.items = items
            }
            .store(in: &cancellables)
    }
}
