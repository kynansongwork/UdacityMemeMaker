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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //Image Picking
    
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
    }
    
    

    @IBAction func resetState(_ sender: Any) {
//        self.resetState(UIButton)
//        self.resetState(sender)
    }
    
}

