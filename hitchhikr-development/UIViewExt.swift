//
//  UIViewExt.swift
//  hitchhikr-development
//
//  Created by Brian Lane on 7/11/17.
//  Copyright © 2017 Brian Lane. All rights reserved.
//

import UIKit

extension UIView {
    
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval){
        UIView.animate(withDuration: duration) { 
            self.alpha = alphaValue
        }
        
    }
    
}
