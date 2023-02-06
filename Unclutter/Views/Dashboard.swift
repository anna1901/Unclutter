//
//  Dashboard.swift
//  Unclutter
//
//  Created by Anna Olak on 10/07/2022.
//

import SwiftUI
import CoreData

struct Dashboard: View {
    private var colors: [Color] = [.cyan, .indigo, .purple, .mint, .blue]
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest<Category>(sortDescriptors: [.init(key: "createdAt", ascending: false)]) var categories
    
    @FetchRequest<Item>(sortDescriptors: [.init(key: "timestamp", ascending: true)]) var items
    
    
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
            .sheet(isPresented: $addCategoryIsPresented, content: {
                AddCategoryView()
            })
            .background() {
                NavigationLink(isActive: $addItemIsPresented, destination: { AddItemView() }, label: {})
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
                ForEach(categories) { category in
                    categoryButton(
                        label: category.name ?? "Default",
                        counter: category.items?.count ?? 0,
                        color: !colors.isEmpty ? colors[(categories.firstIndex(of: category) ?? 0) % colors.count] : .theme.accent)
                }
            })
        }
    }
    
    private func categoryButton(label: String, counter: Int, color: Color) -> some View {
        NavigationLink {
            CategoryView(name: label, context: viewContext)
        } label: {
            VStack {
                Text(label)
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
    
    private var categoriesList: some View {
        List {
            ForEach(categories) { category in
                categoryListRow(
                    label: category.name ?? "Default",
                    counter: category.items?.count ?? 0,
                    color: !colors.isEmpty ? colors[(categories.firstIndex(of: category) ?? 0) % colors.count] : .theme.accent)
            }
        }
        .listStyle(.inset)
    }
    
    private func categoryListRow(label: String, counter: Int, color: Color) -> some View {
        HStack {
            Text(label)
                .font(.headline)
            Spacer()
            Text("\(counter)")
        }
    }
    
    private var totalLabel: some View {
        HStack {
            Text("Total items:")
            Spacer()
            Text("\(items.count)")
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
            Text(String(format: "%.2f", items.map(\.price).reduce(0, +)))
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

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        let persistance = PersistenceController.preview
        Dashboard()
            .environment(\.managedObjectContext, persistance.container.viewContext)
    }
}
