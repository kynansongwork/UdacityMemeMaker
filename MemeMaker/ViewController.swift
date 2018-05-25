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
    @IBOutlet weak var shareButton: UIToolbar!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    let textViewDelegate = textFieldDelegate()
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        //Remeber to set this delegate or the image won't get picked.
        topTextField.delegate = textViewDelegate
        bottomTextField.delegate = textViewDelegate
        
        //Calling text attributes
        topTextField.defaultTextAttributes = textViewDelegate.textAttributes
        bottomTextField.defaultTextAttributes = textViewDelegate.textAttributes
        
        //text alignment
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        
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
    
    //////////////////Image Picking///////////////////////
    
    @IBAction func albumPickerButton(_ sender: Any) {
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
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
    
    ////////////////////Keyboard Behaviour////////////////////////////
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyBoardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y += getKeyBoardHeight(notification)
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
    
    

    @IBAction func resetState(_ sender: Any) {
        let defaultText = "Tap here"
        topTextField.text = defaultText
        bottomTextField.text = defaultText
        memeView.image = nil
        
    }
    

    
}

