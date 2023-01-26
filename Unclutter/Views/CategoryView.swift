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
    private let name: String
    
    init(name: String, context: NSManagedObjectContext) {
        self.vm = CategoryViewModel(name: name, context: context)
        self.name = name
    }
    
    var body: some View {
        List {
            ForEach(vm.items) { item in
                HStack {
                    Text(item.name ?? "No name")
                    Spacer()
                    Text(item.timestamp!, formatter: itemFormatter)
                }
                .padding(.vertical)
            }
            .onDelete(perform: vm.deleteItems)
        }
        .listRowSeparator(.hidden)
        .listStyle(.plain)
        .navigationTitle(name)
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryView(name: "Category 0", context: PersistenceController.preview.container.viewContext)
        }
    }
}
