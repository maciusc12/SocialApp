//
//  CircleView.swift
//  SocialApp
//
//  Created by itelab_maciula on 08.04.2017.
//  Copyright © 2017 itelab_maciula. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        
        clipsToBounds = true
    }
}
