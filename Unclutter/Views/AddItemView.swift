//
//  AddItemView.swift
//  Unclutter
//
//  Created by Anna Olak on 11/07/2022.
//

import SwiftUI

struct AddItemView: View {
    @FetchRequest<Category>(sortDescriptors: [.init(key: "createdAt", ascending: false)]) var categories
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var category: String = ""
    @State private var showNewCategoryField = false
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Name", text: $name)
                .padding()
                .font(.headline)
                .background(Color(hue: 0.519, saturation: 0.0, brightness: 0.932))
                .cornerRadius(10)
            TextField("Price", text: $price)
                .keyboardType(.decimalPad)
                .padding()
                .font(.headline)
                .background(Color(hue: 0.519, saturation: 0.0, brightness: 0.932))
                .cornerRadius(10)
            if showNewCategoryField {
                TextField("Category", text: $category)
                    .padding()
                    .font(.headline)
                    .background(Color(hue: 0.519, saturation: 0.0, brightness: 0.932))
                    .cornerRadius(10)
                if !categories.isEmpty { Button("Select existing category") { showNewCategoryField = false } }
            } else {
                Picker("Category", selection: $category, content: {
                    ForEach(categories.compactMap(\.name), id: \.self) {
                        Text($0)
                    }
                })
                .pickerStyle(.wheel)
                .font(.headline)
                .background(Color(hue: 0.519, saturation: 0.0, brightness: 0.932))
                .cornerRadius(10)
                Button("New category") { showNewCategoryField = true }
            }
            Button(action: {
                addItem()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(hue: 0.893, saturation: 1.0, brightness: 0.712))
                    .cornerRadius(10)
            })
            Spacer()
        }
        .padding()
        .navigationTitle("Add item")
        .onAppear { showNewCategoryField = categories.isEmpty }
    }
    
    private func addItem() {
        withAnimation {
            viewContext.perform {
                let newItem = Item(context: viewContext)
                newItem.name = name
                newItem.price = Double(price) ?? 0
                newItem.timestamp = Date()
                
                if let selectedCategory = categories.first(where: { $0.name == category }) {
                    newItem.category = selectedCategory
                } else {
                    let newCategory = Category(context: viewContext)
                    newCategory.name = category.isEmpty ? "New category" : category
                    newCategory.createdAt = Date()
                    newItem.category = newCategory
                }
                
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
