//
//  FinalApp.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/5.
//

import SwiftUI

@main
struct FinalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
