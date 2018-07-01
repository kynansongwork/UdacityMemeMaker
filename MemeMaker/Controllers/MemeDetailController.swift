//
//  MemeDetailController.swift
//  MemeMaker
//
//  Created by Kynan Song on 19/06/2018.
//  Copyright © 2018 Kynan Song. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailController : UIViewController {
    
    var meme: Meme!
    
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memeImageView!.image = meme.memeImage
        self.memeImageView.contentMode = UIViewContentMode.redraw
        self.tabBarController?.tabBar.isHidden = true
        
        if (UIDeviceOrientationIsPortrait(UIDevice.current.orientation)) {
            self.memeImageView!.contentMode = .scaleAspectFill
        } else {
            self.memeImageView!.contentMode = .scaleAspectFit
            self.memeImageView!.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleBottomMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue) | UInt8(UIViewAutoresizing.flexibleRightMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleLeftMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleTopMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleWidth.rawValue)))
            self.memeImageView.clipsToBounds = true
            //Images in landscape still do not come out as expected. TODO
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
}
