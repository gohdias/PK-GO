//
//  Pokemon_GOApp.swift
//  Shared
//
//  Created by Igor Ferreira Dias on 10/03/21.
//

import SwiftUI

@main
struct Pokemon_GOApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
