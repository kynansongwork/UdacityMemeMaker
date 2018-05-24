//
//  textFieldDelegate.swift
//  MemeMaker
//
//  Created by Kynan Song on 24/05/2018.
//  Copyright © 2018 Kynan Song. All rights reserved.
//

import Foundation
import UIKit

class textFieldDelegate : NSObject, UITextFieldDelegate {
    
    let textAttributes: [String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0
        //Needs to be negative if a foreground colour is set.
    ]
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        //Allows text editing.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
