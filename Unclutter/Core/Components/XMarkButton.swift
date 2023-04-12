//
//  XMarkButton.swift
//  Unclutter
//
//  Created by Anna Olak on 12/04/2023.
//

import SwiftUI

struct XMarkButton: View {
    var dismiss: () -> Void = {}
    
    var body: some View {
        Button(action: {
            dismiss()
        }, label:  {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
