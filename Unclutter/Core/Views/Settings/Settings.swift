//
//  Settings.swift
//  Unclutter
//
//  Created by Anna Olak on 12/04/2023.
//

import SwiftUI

struct Settings: View {
    @ObservedObject private var vm: HomeViewModel
    @State private var newCategory: String = ""
    
    init(vm: HomeViewModel) {
        self._vm = ObservedObject(wrappedValue: vm)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Categories")) {
                ForEach(vm.categories) { category in
                    Text(category.name)
                }
                .onDelete { indices in
                    vm.removeCategory(atOffsets: indices)
                }
                HStack {
                    TextField("New Category", text: $newCategory)
                    Button(action: {
                        withAnimation {
                            vm.addCategory(name: newCategory)
                            newCategory = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add category")
                    }
                    .disabled(newCategory.isEmpty)
                }
            }
        }
        .modifier(FormHiddenBackground())
        .background() {
            Color.theme.background
                .ignoresSafeArea()
        }
        .navigationTitle("Settings")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Settings(vm: dev.homeVM)
        }
    }
}
