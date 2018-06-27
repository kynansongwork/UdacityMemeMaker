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
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = itemSizes()
        
    }
    
    func itemSizes() -> CGSize {
        
        let dimensionWidth = (view.frame.size.width - (2 * 3)) / 3.5
        let dimensionHeight = (view.frame.size.height - (2 * 3)) / 3.5 //currently redundant.
        var itemSize = CGSize()
        
        if view.frame.size.width < view.frame.size.height {
            itemSize = CGSize(width: dimensionWidth, height: dimensionWidth)
        } else {
            itemSize = CGSize(width: dimensionHeight, height: dimensionHeight)
        }
        
        return itemSize
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let memeObject = UIApplication.shared.delegate
        let appDelegate =  memeObject as! AppDelegate
        memes = appDelegate.memes
        collectionView!.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionCell
        
        let savedMeme = memes[(indexPath as NSIndexPath).row]
        
        cell.memeImage?.image = savedMeme.memeImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailController") as! MemeDetailController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
        //Need to set controller storyboard IDs or the app will crash.
    }

}
