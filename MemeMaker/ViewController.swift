//
//  ViewController.swift
//  MemeMaker
//
//  Created by Kynan Song on 24/05/2018.
//  Copyright © 2018 Kynan Song. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var navBar: UIToolbar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    let textViewDelegate = TextFieldDelegate()
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        //Remeber to set this delegate or the image won't get picked.
        topTextField.delegate = textViewDelegate
        bottomTextField.delegate = textViewDelegate
        
        //Calling text attributes
        textViewDelegate.textFieldCustomisation(textField: topTextField, defaultText: "Tap Here")
        textViewDelegate.textFieldCustomisation(textField: bottomTextField, defaultText: "Tap Here")
        
        memeView.contentMode = .scaleAspectFit
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        //If a camera is available, this will be true, enabling the button.
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unsubscribeToKeyboardNotifications()    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shareButton.isEnabled = self.memeView.image != nil
        //if the image view is not empty, the share button will be enabled.
    }
    
    func imagePickingBehaviour(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    //////////////////Image Picking///////////////////////
    
    @IBAction func albumPickerButton(_ sender: Any) {
        imagePickingBehaviour(sourceType: .photoLibrary)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeView.contentMode = .scaleAspectFit
            memeView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
        //Needed to dismiss image picker once an image is selected.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    ///////////////Camera function/////////////////////////
    
    @IBAction func cameraButton(_ sender: Any) {
        imagePickingBehaviour(sourceType: .camera)
    }
    
    ////////////////////Keyboard Behaviour////////////////////////////
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyBoardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    //Checks if bottom text field is furst responder. If so it will shift the view based on keyboard size.
    
    func getKeyBoardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        //Of a CGRectangle
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    ////////////////////meme functions////////////////////////
    
    func generateMemedImage() -> UIImage {
        
        toolBar.isHidden = true
        navBar.isHidden = true
        //When this function is called, the toolbar and navbar are hidden.
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let editedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        //Gets the current image.
        
        toolBar.isHidden = false
        navBar.isHidden = false
        //Returns nav and tool bars once image has been captured.
        
        return editedImage
    }
    
    func save(editedImage: UIImage) {
        
        let memeImage = Meme(
            topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeView.image!, memeImage: editedImage
            //Saves a meme object
        )
        
    }
    
    ////////////////////share functions////////////////////////
    
    @IBAction func shareMeme(_ sender: Any) {
         //meme functions called here
        
        let savedImage = generateMemedImage()
        
        let activityViewController = UIActivityViewController(
        activityItems: [savedImage], applicationActivities: nil)
        //The controller is passed an image, and a meme image is created by the generateMemedImage function
        
        present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = { (_, _, _, _) in
            self.save(editedImage: savedImage)
            //Expects four return types. However in this case, none are available.
        }
    }
    
    //Reset function.

    @IBAction func resetState(_ sender: Any) {
        let defaultText = "Tap here"
        topTextField.text = defaultText
        bottomTextField.text = defaultText
        memeView.image = nil
        
    }
    
    /**Learnt from Udacity,https://www.raywenderlich.com/133825/uiactivityviewcontroller-tutorial, http://swiftlylearning.blogspot.co.uk and http://www.codingexplorer.com/choosing-images-with-uiimagepickercontroller-in-swift/
     **/
}

