//
//  CategoryView.swift
//  Unclutter
//
//  Created by Anna Olak on 26/01/2023.
//

import SwiftUI
import CoreData

struct CategoryView: View {
    @ObservedObject var vm: CategoryViewModel
    
    init(category: CategoryModel) {
        self.vm = CategoryViewModel(category: category)
    }
    
    var body: some View {
        List {
            ForEach(vm.items) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    Text(item.soldAt, formatter: itemFormatter)
                }
                .padding(.vertical)
            }
            .onDelete(perform: vm.deleteItems)
        }
        .listRowSeparator(.hidden)
        .listStyle(.plain)
        .navigationTitle(vm.categoryName)
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            CategoryView(name: "Category 0")
//        }
//    }
//}
