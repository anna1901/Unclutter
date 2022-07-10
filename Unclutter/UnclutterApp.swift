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
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
