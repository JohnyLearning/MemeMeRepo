//
//  MemeTextDelegate.swift
//  ImagePicker
//
//  Created by Ivan Hadzhiiliev on 2019-12-29.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeTextDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
