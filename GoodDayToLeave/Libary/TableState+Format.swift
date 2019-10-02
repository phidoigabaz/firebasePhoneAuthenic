//
//  State+Format.swift
//  StateView
//
//  Created by Alberto Aznar de los Ríos on 27/05/2019.
//  Copyright © 2019 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit
import EmptyStateKit

extension TableState {
    
    var format: EmptyStateFormat {
        switch self {
            
        case .noLogin:
            var format = EmptyStateFormat()
            format.buttonColor = "44CCD6".hexColor
            format.position = EmptyStatePosition(view: .top, text: .right, image: .top)
            format.animation = EmptyStateAnimation.fade(0.3, 0.3)
            format.verticalMargin = 20
            format.horizontalMargin = 40
            format.imageSize = CGSize(width: 320, height: 200)
            format.buttonShadowRadius = 10
            return format
            
        }
    }
}
