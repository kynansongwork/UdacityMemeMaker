//
//  MemeTableViewController.swift
//  MemeMaker
//
//  Created by Kynan Song on 19/06/2018.
//  Copyright © 2018 Kynan Song. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {


    var memes: [Meme]!
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let memeObject = UIApplication.shared.delegate
        let appDelegate =  memeObject as! AppDelegate
        memes = appDelegate.memes
        self.tabBarController?.tabBar.isHidden = false
        tableView!.reloadData()
        //Needed to update the table view.
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        let savedMeme = memes[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = savedMeme.topText
        cell.detailTextLabel?.text = savedMeme.bottomText
            
        cell.imageView?.image = savedMeme.memeImage
            
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let tableDetailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailController") as! MemeDetailController
        tableDetailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(tableDetailController, animated: true)
    }
        
        
}

