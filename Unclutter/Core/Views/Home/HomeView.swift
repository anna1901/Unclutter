//
//  Dashboard.swift
//  Unclutter
//
//  Created by Anna Olak on 10/07/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm: HomeViewModel
    @State var addItemIsPresented = false
    @State var categoryViewIsPresent = false
    
    private let currencyCode = "USD"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                summaryArea
                categoriesContainer
                addItemButton
                    .padding()
            }
            .sheet(isPresented: $addItemIsPresented, content: {
                NavigationView {
                    AddItemView(vm: vm)
                }
            })
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .background() {
                Color.theme.background
                    .ignoresSafeArea()
            }
            .navigationTitle("Unclutter")
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        Settings(vm: vm)
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.headline)
                    }
                }
            }
            .onAppear {
                vm.refresh()
            }
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
            if vm.categories.isEmpty {
                Spacer()
                Text("Add first item that you successfully uncluttered!")
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .foregroundColor(Color.theme.accent)
            } else {
                CategoriesList(categories: vm.categories)
            }
        }
    }
    
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
            Text(vm.soldItemsPrice, format: .currency(code: currencyCode))
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.theme.accent, lineWidth: 2)
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
        .shadow(
            color: .theme.accent,
            radius: 5, x: 0, y: 0
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: dev.homeVM)
    }
}
