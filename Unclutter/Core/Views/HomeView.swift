//
//  Dashboard.swift
//  Unclutter
//
//  Created by Anna Olak on 10/07/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    @State var addCategoryIsPresented = false
    @State var addItemIsPresented = false
    @State var categoryViewIsPresent = false
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                summaryArea
                categoriesContainer
                addItemButton
                    .padding()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .background() {
                NavigationLink(isActive: $addItemIsPresented, destination: { AddItemView(vm: vm) }, label: {})
                NavigationLink(isActive: $addCategoryIsPresented, destination: { AddCategoryView() }, label: {})
                Color.theme.background
                    .ignoresSafeArea()
            }
            .navigationTitle("Unclutter")
        }
    }
    
    private var summaryArea: some View {
        VStack {
            totalLabel
            amountLabel
        }
        .padding(.bottom)
    }
    
    private var categoriesContainer: some View {
        VStack {
            addCategoryButton
            categoriesGrid
        }
    }
    
    private var categoriesGrid: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20, content: {
                ForEach(vm.categories) { category in
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
            CategoryView(category: category)
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
    
//    private var categoriesList: some View {
//        List {
//            ForEach(vm.categories) { category in
//                categoryListRow(
//                    label: category.name,
//                    counter: category.itemsCount,
//                    color: Color.theme.accent)
//            }
//        }
//        .listStyle(.inset)
//    }
//
//    private func categoryListRow(label: String, counter: Int, color: Color) -> some View {
//        HStack {
//            Text(label)
//                .font(.headline)
//            Spacer()
//            Text("\(counter)")
//        }
//    }
    
    private var totalLabel: some View {
        HStack {
            Text("Total items:")
            Spacer()
            Text("\(vm.itemsCount)")
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.theme.accent, lineWidth: 2)
        }
    }
    
    private var amountLabel: some View {
        HStack {
            Text("Earned:")
            Spacer()
            Text(String(format: "%.2f", vm.soldItemsPrice))
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.theme.accent, lineWidth: 2)
        }
    }
    
    private var addCategoryButton: some View {
        HStack {
            Spacer()
            Button("Add category") {
                addCategoryIsPresented = true
            }
        }
    }
    
    private var addItemButton: some View {
        Button(action: {
            addItemIsPresented = true
        }, label: {
            Text("+")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .background {
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.theme.accent)
                }
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
