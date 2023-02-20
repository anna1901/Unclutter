//
//  AddItemView.swift
//  Unclutter
//
//  Created by Anna Olak on 11/07/2022.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var vm: HomeViewModel
    
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var category: String = ""
    @State private var showNewCategoryField = false
    
    init(vm: HomeViewModel) {
        self._vm = ObservedObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Name", text: $name)
                .padding()
                .font(.headline)
                .background(Color.theme.textfieldBackground)
                .cornerRadius(10)
            TextField("Price", text: $price)
                .keyboardType(.decimalPad)
                .padding()
                .font(.headline)
                .background(Color.theme.textfieldBackground)
                .cornerRadius(10)
            if showNewCategoryField {
                TextField("Category", text: $category)
                    .padding()
                    .font(.headline)
                    .background(Color.theme.textfieldBackground)
                    .cornerRadius(10)
                if !vm.categories.isEmpty { Button("Select existing category") { showNewCategoryField = false } }
            } else {
                Picker("Category", selection: $category, content: {
                    ForEach(vm.categories.map(\.name), id: \.self) {
                        Text($0)
                    }
                })
                .pickerStyle(.wheel)
                .font(.headline)
                .background(Color.theme.textfieldBackground)
                .foregroundColor(Color.theme.background)
                .cornerRadius(10)
                Button("New category") { showNewCategoryField = true }.foregroundColor(Color.theme.accent)
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
                    .background(Color.theme.accent)
                    .cornerRadius(10)
            })
            Spacer()
        }
        .padding()
        .navigationTitle("Add item")
        .onAppear {
            showNewCategoryField = vm.categories.isEmpty
            category = vm.categories.first?.name ?? ""
        }
        .background(Color.theme.background)
    }
    
    private func addItem() {
        withAnimation {
            vm.addItem(name: name, price: price, categoryName: category)
        }
    }
}
//
//struct AddItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemView()
//    }
//}
