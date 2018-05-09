//
//  ViewController.swift
//  FJCube
//
//  Created by jin fu on 2018/5/9.
//  Copyright © 2018年 Jiuhuar. All rights reserved.
//

import UIKit
import GLKit
class ViewController: UIViewController {
    
    @IBOutlet var faces: [UIView]!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTransform()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for face in faces {
            face.center = containerView.center
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configTransform() {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500
        perspective = CATransform3DRotate(perspective, CGFloat(-Double.pi/4), 1, 0, 0)
        perspective = CATransform3DRotate(perspective, CGFloat(-Double.pi/4), 0, 1, 0)
        containerView.layer.sublayerTransform = perspective
        
        let translation: CGFloat = 150/2.0
        
        // face1
        var transform = CATransform3DMakeTranslation(0, 0, translation)
        addFace(index: 0, with: transform)
        
        // face2
        transform = CATransform3DMakeTranslation(translation, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat(Double.pi/2), 0, 1, 0)
        addFace(index: 1, with: transform)
        
        // face3
        transform = CATransform3DMakeTranslation(0, -translation, 0)
        transform = CATransform3DRotate(transform, CGFloat(Double.pi/2), 1, 0, 0)
        addFace(index: 2, with: transform)
        
        // face4
        transform = CATransform3DMakeTranslation(0, translation, 0)
        transform = CATransform3DRotate(transform, CGFloat(-Double.pi/2), 1, 0, 0)
        addFace(index: 3, with: transform)
        
        // face5
        transform = CATransform3DMakeTranslation(-translation, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat(-Double.pi/2), 0, 1, 0)
        addFace(index: 4, with: transform)
        
        // face6
        transform = CATransform3DMakeTranslation(0, 0, -translation)
        transform = CATransform3DRotate(transform, CGFloat(Double.pi), 0, 1, 0)
        addFace(index: 5, with: transform)
    }
    
    func addFace(index: Int, with transform: CATransform3D) {
        let face = faces[index]
        containerView.addSubview(face)
        
        face.layer.transform = transform
        applyLightingToFace(face.layer)
    }
    
    func applyLightingToFace(_ face: CALayer) {
        let layer = CALayer()
        layer.frame = face.bounds
        face.addSublayer(layer)
        
        let transform = face.transform
        let matrix4: GLKMatrix4 = transformation(transform: transform)
        let matrix3: GLKMatrix3 = GLKMatrix4GetMatrix3(matrix4)
        var normal = GLKVector3Make(0, 0, 1)
        normal = GLKMatrix3MultiplyVector3(matrix3, normal)
        normal = GLKVector3Normalize(normal)
        
        let light = GLKVector3Normalize(GLKVector3Make(0, 1, -0.5))
        
        let dotProduct: Float = GLKVector3DotProduct(light, normal)
        
        let shadow: CGFloat = 1 + CGFloat(dotProduct) - 0.5
        
        let color = UIColor.init(white: 0, alpha: shadow)
        layer.backgroundColor = color.cgColor
    }
    
    func transformation(transform: CATransform3D) -> GLKMatrix4 {
        let matrix4 = GLKMatrix4.init(m: (Float(transform.m11), Float(transform.m12), Float(transform.m13), Float(transform.m14), Float(transform.m21), Float(transform.m22), Float(transform.m23), Float(transform.m24), Float(transform.m31), Float(transform.m32), Float(transform.m33), Float(transform.m34), Float(transform.m41), Float(transform.m42), Float(transform.m43), Float(transform.m44)))
        return matrix4
    }
    
    @IBAction func fjAction(_ sender: Any) {
        var perspective = containerView.layer.sublayerTransform
        perspective = CATransform3DRotate(perspective, CGFloat(Double.pi/6), 1, 0, 0)
        containerView.layer.sublayerTransform = perspective
    }
    
}

