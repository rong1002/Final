//
//  ContentView.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/5.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        FBFirst()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
