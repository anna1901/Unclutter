//
//  CategoriesList.swift
//  Unclutter
//
//  Created by Anna Olak on 11/04/2023.
//

import SwiftUI

struct CategoriesList: View {
    var categories: [CategoryModel]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20, content: {
                ForEach(categories) { category in
                    categoryButton(
                        category: category,
                        counter: category.itemsCount,
                        color: Color.theme.accent)
                }
            })
        }
    }
    
    private func categoryButton(category: CategoryModel, counter: Int, color: Color) -> some View {
        NavigationLink {
            CategoryView(vm: CategoryViewModel(category: category))
        } label: {
            VStack {
                Text(category.name)
                    .font(.headline)
                    .scaledToFill()
                Spacer()
                Text("\(counter)")
                    .font(.headline)
            }
            .foregroundColor(.white)
            .padding(20)
        }
        .frame(maxWidth: 160)
        .background(color)
        .cornerRadius(10)
    }
}

struct CategoriesList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoriesList(categories: dev.categories)
        }
    }
}
