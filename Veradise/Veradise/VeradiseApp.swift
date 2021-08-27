//
//  VeradiseApp.swift
//  Veradise
//
//  Created by Rinaldi LNU on 09/08/21.
//

import SwiftUI

@main
struct VeradiseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            TabBar()
        }
    }
}
