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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
}
