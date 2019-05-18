//
//  ViewController.swift
//  AR Welcome
//
//  Created by Denis Bystruev on 18/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
        
        loadCampus()
        loadCampusFromCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}


// MARK: - Campus Creation
extension ViewController {
    func loadCampus() {
        let scene = SCNScene(named: "art.scnassets/Campus.scn")!
        let node = scene.rootNode.clone()
        node.position = SCNVector3(-2, -0.5, -3)
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func loadCampusFromCode() {
        let campus = SCNNode()
        campus.position = SCNVector3(2, -0.5, -3)
        
        let building = getBuilding()
        campus.addChildNode(building)
        
        let grass = getGrass()
        grass.position.y -= 0.501
        campus.addChildNode(grass)
        
        sceneView.scene.rootNode.addChildNode(campus)
    }
    
    func getBuilding() ->SCNNode {
        let colors = [#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        let materials = colors.map { color -> SCNMaterial in
            let material = SCNMaterial()
            material.diffuse.contents = color
            return material
        }
        
        let box = SCNBox(width: 3, height: 1, length: 1, chamferRadius: 0)
        box.materials = materials
        
        let building = SCNNode(geometry: box)
        
        return building
    }
    
    
    func getGrass() -> SCNNode {
        let plane = SCNPlane(width: 4, height: 2)
        plane.firstMaterial?.diffuse.contents = UIImage(named: "grass")
        
        let grass = SCNNode(geometry: plane)
        grass.eulerAngles.x = -.pi / 2
        
        return grass
    }
}
