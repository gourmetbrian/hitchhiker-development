//
//  CenterVCDelegate.swift
//  hitchhikr-development
//
//  Created by Brian Lane on 7/11/17.
//  Copyright © 2017 Brian Lane. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    
    func addLeftPanelViewController()
    
    func animateLeftPanel(shouldExpand: Bool)
}
