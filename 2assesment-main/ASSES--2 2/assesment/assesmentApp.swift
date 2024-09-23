//
//  assesmentApp.swift
//  assesment
//
//  Created by Volkan Yagci on 8/24/24.
//

import SwiftUI

@main
struct assesmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
