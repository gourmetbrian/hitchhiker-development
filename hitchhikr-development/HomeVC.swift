//
//  ViewController.swift
//  hitchhikr-development
//
//  Created by Brian Lane on 7/10/17.
//  Copyright © 2017 Brian Lane. All rights reserved.
//

import UIKit
import MapKit
import RevealingSplashView

class HomeVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var actionButton: RoundedShadowButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: CenterVCDelegate?
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        self.view.addSubview(revealingSplashView)
//        revealingSplashView.animationType = SplashAnimationType.twitter
        revealingSplashView.animationType = SplashAnimationType.squeezeAndZoomOut
//        revealingSplashView.animationType = SplashAnimationType.swingAndZoomOut
//        revealingSplashView.animationType = SplashAnimationType.heartBeat
        
        revealingSplashView.startAnimation()
        revealingSplashView.heartAttack = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionButtonPressed(_ sender: Any) {
        actionButton.animateButton(shouldLoad: true, withMessage: nil)
    }
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
        
    }

}

