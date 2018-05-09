//
//  FJReflectionView.swift
//  FJCube
//
//  Created by jin fu on 2018/5/9.
//  Copyright © 2018年 Jiuhuar. All rights reserved.
//

import UIKit

class FJReflectionView: UIView {
    
    override class var layerClass: Swift.AnyClass
    {
        return CAReplicatorLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func setUp() {
        let layer = self.layer as! CAReplicatorLayer
        layer.instanceCount = 2
        
        var transform = CATransform3DIdentity
        
        transform = CATransform3DTranslate(transform, 0, self.bounds.height, 0)
        transform = CATransform3DScale(transform, 1, -1, 0)
        layer.instanceTransform = transform
        
        layer.instanceAlphaOffset = -0.6
    }
}
