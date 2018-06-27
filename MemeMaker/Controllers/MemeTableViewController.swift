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
    var deleteMemeIndexPath: NSIndexPath? = nil
        
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
    
    
    //Delete functionality
    //Found on stackOverflow and https://www.andrewcbancroft.com/2015/07/16/uitableview-swipe-to-delete-workflow-in-swift/
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            deleteMemeIndexPath = indexPath as NSIndexPath
            let memeToDelete = memes[indexPath.row]
            confirmDelete(meme: memeToDelete)
        }
    //This will delete the data from array and will update the views.
    }
    
    func confirmDelete(meme: Meme) {
        let alert = UIAlertController(title: "Delete Meme", message: "Do you want to delete this meme?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteMeme)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteMeme)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func handleDeleteMeme(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteMemeIndexPath {
            tableView.beginUpdates()
            memes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)

            deleteMemeIndexPath = nil
            tableView.endUpdates()
        }
    }
    
    func cancelDeleteMeme(alertAction: UIAlertAction!) {
        deleteMemeIndexPath = nil
    }
    
    //Currently only a temporary delete. Only deletes from present view but returns if the page is left. Need to delete from collection view as well.
}

