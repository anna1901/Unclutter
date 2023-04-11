//
//  CategoryView.swift
//  Unclutter
//
//  Created by Anna Olak on 26/01/2023.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var vm: CategoryViewModel
    
    var body: some View {
        List {
            ForEach(vm.items) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    Text(item.soldAt, style: .date)
                }
                .padding(.vertical)
            }
            .onDelete(perform: vm.deleteItems)
        }
        .listRowSeparator(.hidden)
        .listStyle(.plain)
        .navigationTitle(vm.categoryName)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryView(vm: dev.categoryVM)
        }
    }
}
