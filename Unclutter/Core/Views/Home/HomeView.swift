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
                Color.theme.background
                    .ignoresSafeArea()
            }
            .navigationTitle("Unclutter")
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
            CategoriesList(categories: vm.categories)
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
            Text(String(format: "%.2f", vm.soldItemsPrice))
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
