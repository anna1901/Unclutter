//
//  AddItemView.swift
//  Unclutter
//
//  Created by Anna Olak on 11/07/2022.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
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
            nameTextField
            priceTextField
            if showNewCategoryField {
                newCategoryField
            } else {
                categoriesPicker
            }
            saveButton
            Spacer()
        }
        .padding()
        .navigationTitle("Add item")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                XMarkButton { dismiss() }
            }
        }
        .onAppear {
            showNewCategoryField = vm.categories.isEmpty
            category = vm.categories.first?.name ?? ""
        }
        .onDisappear {
            vm.addItemViewDismissed()
        }
        .background(Color.theme.background)
    }
    
    private func addItem() {
        withAnimation {
            vm.addItem(name: name, price: price, categoryName: category) {
                dismiss()
            }
        }
    }
    
    private var nameTextField: some View {
        VStack(alignment: .leading) {
            TextField("Name", text: $name)
                .padding()
                .font(.headline)
                .background(Color.theme.textfieldBackground)
            .cornerRadius(10)
            if vm.nameInvalid {
                Text("Name can't be empty")
                    .font(.callout)
                    .foregroundColor(.red)
                    .padding(.leading, 5)
            }
        }
    }
    
    private var priceTextField: some View {
        TextField("Price", text: $price)
            .keyboardType(.decimalPad)
            .padding()
            .font(.headline)
            .background(Color.theme.textfieldBackground)
            .cornerRadius(10)
    }
    
    private var newCategoryField: some View {
        VStack {
            VStack(alignment: .leading) {
                TextField("Category", text: $category)
                    .padding()
                    .font(.headline)
                    .background(Color.theme.textfieldBackground)
                    .cornerRadius(10)
                if vm.categoryInvalid {
                    Text("Category name can't be empty")
                        .font(.callout)
                        .foregroundColor(.red)
                        .padding(.leading, 5)
                }
            }
            if !vm.categories.isEmpty {
                Button("Select existing category") {
                    showNewCategoryField = false
                }
                .padding(.top, 10)
            }
        }
    }
    
    private var categoriesPicker: some View {
        VStack {
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
            .frame(height: 100)
            
            Button("New category") {
                showNewCategoryField = true
                category = ""
            }
            .foregroundColor(Color.theme.accent)
            .padding(.top, 10)
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            addItem()
        }, label: {
            Text("Save")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.theme.accent)
                .cornerRadius(10)
        })
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddItemView(vm: dev.homeVM)
        }
    }
}
