//
//  ContentView.swift
//  visionOS_VR
//
//  Created by Siyona Dhingra on 2/17/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            Button {
                Task{
                    await openImmersiveSpace(id: "ImmersiveSpace")
                    immersiveSpaceIsShown = true
                }
            } label: {
                Image(systemName: "visionpro")
            }
            
            if(immersiveSpaceIsShown){
                Button {
                    Task {
                        await dismissImmersiveSpace()
                        immersiveSpaceIsShown = false
                    }
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
