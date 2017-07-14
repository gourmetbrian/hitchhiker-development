//
//  UIViewControllerExt.swift
//  hitchhikr-development
//
//  Created by Brian Lane on 7/14/17.
//  Copyright © 2017 Brian Lane. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func shouldPresentLoadingView(_ status: Bool) {
        var fadeView: UIView?
        
        if status {
            fadeView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            fadeView?.backgroundColor = UIColor.black
            fadeView?.alpha = 0.0
            fadeView?.tag = 2001
            
            let spinner = UIActivityIndicatorView()
            spinner.color = UIColor.white
            spinner.activityIndicatorViewStyle = .whiteLarge
            spinner.center = view.center
            
            view.addSubview(fadeView!)
            fadeView?.addSubview(spinner)
            fadeView?.fadeTo(alphaValue: 0.7, withDuration: 0.2)
            
            spinner.startAnimating()
        } else {
            for subview in view.subviews {
                if subview.tag == 2001 {
                    UIView.animate(withDuration: 0.2, animations: { 
                        subview.alpha = 0.0
                    }, completion: { (finished) in
                        subview.removeFromSuperview()
                    })
                }
            }
        }
    }
}
