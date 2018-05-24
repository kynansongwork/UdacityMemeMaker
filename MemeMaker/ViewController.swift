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
    
    let textViewDelegate = textFieldDelegate()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = textViewDelegate
        bottomTextField.delegate = textViewDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

