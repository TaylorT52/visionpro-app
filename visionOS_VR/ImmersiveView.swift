//
//  ImmersiveView.swift
//  visionOS_VR
//
//  Created by Siyona Dhingra on 2/17/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        //reality view specifically tailored for immersive
        RealityView { content in
            
            //create a skybox entity
            //skybox is giant sphere wrapped in image to represent a immersive view
            //skybox
            if let skyboxEntity = createSkyBox(){
                //add to realityview/content
                content.add(skyboxEntity)
            } else {
                print("Error loading skybox")
            }
            
            //saturn entity
            let saturnEntity = await createSaturnModel()
            saturnEntity.setPosition(SIMD3<Float>(-0.05, -0.2, 0.1), relativeTo: nil)
            content.add(saturnEntity)
            
            //skin block entity
            let skinEntity = await createSkinModel()
            content.add(skinEntity)
            
            print(getEntityPos(entityName: skinEntity))
            print(getEntityPos(entityName: saturnEntity)) //should be not 0, 0, 0
            
//            //triangle entity
//            if let triangleEntity = createTriEntity() {
//                content.add(triangleEntity)
//            } else {
//                print("Error in loading triangle entity")
//            }
        }
    }
    
    private func createSkyBox () -> Entity? {
        
        //mesh (a large sphere)
        //let largeSphere = MeshResource.generateSphere(radius: 1000)
        
        let largeCube = MeshResource.generateBox(size: 1000)
        
        //material applied to mesh
        var skyBoxMaterial = UnlitMaterial()
        
        do {
            let texture = try TextureResource.load(named: "galaxy")
            skyBoxMaterial.color = .init(texture: .init(texture))
            //applies the defined texture to the skyboxmaterial
        } catch {
            print("error loading texture")
        }
        
        //skybox entity created
        let skyboxEntity = Entity()
        skyboxEntity.components.set(ModelComponent(mesh: largeCube, materials: [skyBoxMaterial]))
        
        //map texture to INNER surface of sphere
        skyboxEntity.scale *= .init(x: -1, y: 1, z: 1)
        
        return skyboxEntity
    }
    
    //creates a saturn model
    private func createSaturnModel () async -> Entity {
        guard let saturnEnt = try? await Entity(named: "Immersive", in: realityKitContentBundle) else {
            fatalError("Saturn Model not loading")
        }
        
        return saturnEnt
    }
    
    //creates a skin model
    private func createSkinModel () async -> Entity {
        guard let skinEnt = try? await Entity(named: "block of skin", in: realityKitContentBundle) else {
            fatalError("Skin Model not loading")
        }
        
        return skinEnt
    }
    
    //creates a triangle model
    private func createTriEntity () -> Entity? {
        /* CREATING THE MESH*/
        //coordinates
        let _: [SIMD3<Float>] = [[-1, -1, 0], [1, -1, 0], [0, 1, 0]]
        
        //creating mesh with those coordinates
        var descr = MeshDescriptor(name: "triangle")
        descr.positions = MeshBuffers.Positions(
          [[-1, -1, 0], [1, -1, 0], [0, 1, 0]]
        )
        
        //conects them in a triangle format
        descr.primitives = .triangles([0, 1, 2]) //drawn in counterclockwise format
        
        /* CREATING THE ENTITY FROM MESH */
        let generatedModel = ModelEntity(
           mesh: try! .generate(from: [descr]),
           materials: [SimpleMaterial(color: .brown, isMetallic: false)]
        )
        
        /* APPLYING A TEXTURE */
        
        
        /* RETURNING THE ENTITY*/
        return generatedModel
    }
    
    private func getEntityPos (entityName: Entity) -> SIMD3<Float> {
        return entityName.position(relativeTo: nil)
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
