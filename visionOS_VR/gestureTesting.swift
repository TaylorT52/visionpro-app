//
//  gestureTesting.swift
//  visionOS_VR
//
//  Created by Siyona Dhingra on 3/13/24.
//

import SwiftUI
import UIKit

//struct gestureTesting: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        
//            .gesture(
//                        DragGesture(minimumDistance: 0)
//                            .targetedToAnyEntity()
//                            .onChanged { value in
//                                let startLocation = value.convert(value.startLocation3D, from: .local, to: .scene)
//                                let currentLocation = value.convert(value.location3D, from: .local, to: .scene)
//                                let delta = currentLocation - startLocation
////                                spinX = Double(delta.y) * 5
////                                spinY = Double(delta.x) * 5
//                            }
//                    )
//    }
//}

struct gestureTesting: View {
    @State private var isDragging = false
  
    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in self.isDragging = true }
            .onEnded { _ in self.isDragging = false }
            
    }

    var body: some View {
        
        VStack{
            Spacer()
            
            Circle()
                .fill(.red)
                .frame(width: 100, height: 100)
                .onTapGesture(coordinateSpace: .global) { location in
                    print("Tapped at \(location)")
                }
            
            Spacer(minLength: 10)
            
            Circle()
                .fill(self.isDragging ? Color.red : Color.blue)
                .frame(width: 100, height: 100, alignment: .center)
                //.gesture(drag)
                .onTouch(limitToBounds: false, perform: updateLocation)
            
            Spacer()
            
        }
    }
    
    func updateLocation(_ location: CGPoint) {
        print(location)
    }
}

#Preview {
    gestureTesting()
}
