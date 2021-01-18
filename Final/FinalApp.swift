//
//  FinalApp.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/5.
//

import SwiftUI
import FacebookCore

@main
struct FinalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                })
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}
