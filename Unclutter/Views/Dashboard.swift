//
//  Dashboard.swift
//  Unclutter
//
//  Created by Anna Olak on 10/07/2022.
//

import SwiftUI
import CoreData

struct Dashboard: View {
    var colors: [Color] = [.cyan, .indigo, .purple, .mint, .blue]
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest<Category>(sortDescriptors: [.init(key: "createdAt", ascending: false)]) var categories
    
    @FetchRequest<Item>(sortDescriptors: [.init(key: "timestamp", ascending: true)]) var items
    
    
    @State var addCategoryIsPresented = false
    @State var addItemIsPresented = false
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                summaryArea
                categoriesList
                addItemButton
                    .padding()
            }
//            .padding(.top, 20)
            .padding(.horizontal, 20)
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
    
    private var categoriesList: some View {
        ScrollView {
            addCategoryButton
            buttonsGrid
            Spacer()
        }
    }
    
    func categoryButton(label: String, counter: Int, color: Color) -> some View{
        Button(action: {
            //
        }, label: {
            VStack {
                Text(label)
                    .bold()
                    .scaledToFill()
                Spacer()
                Text("\(counter)")
                    .bold()
            }
            .padding()
            .foregroundColor(.white)
        })
        .frame(width: 140, height: 90)
        .background {
            color
        }
    }
    
    var buttonsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20, content: {
            ForEach(categories) { category in
                categoryButton(
                    label: category.name ?? "Default",
                    counter: category.items?.count ?? 0,
                    color: !colors.isEmpty ? colors[(categories.firstIndex(of: category) ?? 0) % colors.count] : .mint)
            }
        })
    }
    
    var totalLabel: some View {
        HStack {
            Text("Total items:")
            Spacer()
            Text("\(items.count)")
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.mint, lineWidth: 2)
        }
    }
    
    var amountLabel: some View {
        HStack {
            Text("Earned:")
            Spacer()
            Text(String(format: "%.2f", items.map(\.price).reduce(0, +)))
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.mint, lineWidth: 2)
        }
    }
    
    var addCategoryButton: some View {
        HStack {
            Spacer()
            Button("Add category") {
                addCategoryIsPresented = true
            }
        }
    }
    
    var addItemButton: some View {
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
                        .foregroundColor(.mint)
                }
        })
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
