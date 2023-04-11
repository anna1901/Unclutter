//
//  UnclutterApp.swift
//  Unclutter
//
//  Created by Anna Olak on 10/07/2022.
//

import SwiftUI

@main
struct UnclutterApp: App {
    @StateObject var vm: HomeViewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView(vm: vm)
        }
    }
}
