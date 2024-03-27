//
//  visionpro_appApp.swift
//  visionpro-app
//
//  Created by Taylor Tam on 3/27/24.
//

import SwiftUI

@main
struct visionpro_appApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
