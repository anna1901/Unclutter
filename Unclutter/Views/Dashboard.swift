//
//  Dashboard.swift
//  Unclutter
//
//  Created by Anna Olak on 10/07/2022.
//

import SwiftUI

struct Dashboard: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                totalLabel
                amountLabel
                buttons
                Spacer()
                addButton
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal, 50)
            .navigationTitle("Unclutter")
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
        .frame(width: 120, height: 100)
        .background {
            color
        }
    }
    
    var buttons: some View {
        VStack(spacing: 30) {
            HStack {
                categoryButton(label: "Sold:", counter: 1, color: .cyan)
                Spacer()
                categoryButton(label: "Given away:", counter: 2, color: .indigo)
            }
            HStack {
                categoryButton(label: "Exchanged:", counter: 1, color: .mint)
                Spacer()
                categoryButton(label: "Thrown away:", counter: 2, color: .purple)
            }
        }
    }
    
    var totalLabel: some View {
        HStack {
            Text("Total items:")
            Spacer()
            Text("6")
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
            Text("60")
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.mint, lineWidth: 2)
        }
    }
    
    var addButton: some View {
        Button(action: {}, label: {
            Text("+")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .background {
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)
                }
        })
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
