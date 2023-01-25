//
//  UnclutterApp.swift
//  Unclutter
//
//  Created by Anna Olak on 10/07/2022.
//

import SwiftUI

@main
struct UnclutterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Dashboard()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
