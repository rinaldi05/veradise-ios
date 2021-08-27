//
//  VeradiseApp.swift
//  Watch Extension
//
//  Created by Rinaldi LNU on 16/08/21.
//

import SwiftUI

@main
struct VeradiseApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
