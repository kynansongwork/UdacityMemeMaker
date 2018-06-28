//
//  TextFieldDelegate.swift
//  MemeMaker
//
//  Created by Kynan Song on 24/05/2018.
//  Copyright © 2018 Kynan Song. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate : NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Tap Here" {
            textField.text = ""
        }
        //Allows text editing. Doesn't delete the text unless the default text is there.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldCustomisation(textField: UITextField, defaultText: String) {
        let textAttributes: [String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
            NSAttributedStringKey.strokeWidth.rawValue: -3.0
            //Needs to be negative if a foreground colour is set.
        ]
        
        textField.defaultTextAttributes = textAttributes
        textField.text = defaultText
        textField.textAlignment = .center
        
    }
    
    
}
