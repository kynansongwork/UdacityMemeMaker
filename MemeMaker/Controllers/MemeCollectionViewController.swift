//
//  MemeCollectionViewController.swift
//  MemeMaker
//
//  Created by Kynan Song on 19/06/2018.
//  Copyright © 2018 Kynan Song. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController : UICollectionViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let memes = appDelegate.memes
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
