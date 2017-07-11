//
//  RoundImageView.swift
//  hitchhikr-development
//
//  Created by Brian Lane on 7/11/17.
//  Copyright © 2017 Brian Lane. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    

}
