//
//  BlockView.swift
//  visionpro-app
//
//  Created by Taylor Tam on 3/27/24.
//

import Foundation

import Foundation
import SwiftUI
import _RealityKit_SwiftUI

struct BlockView: View {
    @State private var scale = false

    var body: some View {
        RealityView { content in
            let model = ModelEntity(
                mesh: .generateBox(size: 0.1),
                materials: [SimpleMaterial(color: .white, isMetallic: true)])


            // Enable interactions on the entity.
            model.components.set(InputTargetComponent())
            model.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.1)]))
            content.add(model)
        } update: { content in
            if let model = content.entities.first {
                model.transform.scale = scale ? [1.2, 1.2, 1.2] : [1.0, 1.0, 1.0]
            }
        }
        .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
            scale.toggle()
        })
    }
}
