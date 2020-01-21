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
    
    var text: String?
    var editing: Bool = false
    
    init(text: String?) {
        self.text = text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == MemeEditorViewController.TOP_WRITING_INITAL_TEXT ||
            textField.text == MemeEditorViewController.BOTTOM_WRITING_INITAL_TEXT
        {
            textField.text = ""
        }
        editing = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? false {
            textField.text = self.text
        }
        editing = false
    }
    
}
