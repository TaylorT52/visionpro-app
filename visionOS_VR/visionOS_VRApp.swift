//
//  visionOS_VRApp.swift
//  visionOS_VR
//
//  Created by Siyona Dhingra on 2/17/24.
//

import SwiftUI

@main
struct visionOS_VRApp: App {
    
    @State var immersionMode:ImmersionStyle = .progressive
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: 10, height: 10)
        .windowStyle(.plain)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
        .immersionStyle(selection: $immersionMode , in: .progressive)
    }
}
