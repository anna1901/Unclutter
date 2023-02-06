//
//  AddCategoryView.swift
//  Unclutter
//
//  Created by Anna Olak on 10/07/2022.
//

import SwiftUI

struct AddCategoryView: View {
    @State var name: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Name", text: $name)
                .padding()
                .font(.headline)
                .background(Color.theme.textfieldBackground)
                .cornerRadius(10)
            Button("Save") {
                addItem()
                presentationMode.wrappedValue.dismiss()
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.theme.accent)
            .cornerRadius(10)
            Spacer()
        }
        .padding()
        .navigationTitle("Add category")
    }
    
    private func addItem() {
        withAnimation {
            viewContext.perform {
                let newItem = Category(context: viewContext)
                newItem.name = name
                newItem.createdAt = Date()

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

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddCategoryView()
        }
    }
}
