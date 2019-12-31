//
//  Extension+ViewController.swift
//  MemeMe
//
//  Created by Ivan Hadzhiiliev on 2019-12-29.
//  Copyright © 2019 Udacity. All rights reserved.
//
// reference: https://stackoverflow.com/questions/32281651/how-to-dismiss-keyboard-when-touching-anywhere-outside-uitextfield-in-swift

import Foundation
import UIKit

extension ViewController  {
    
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePicker.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {

        setToolbarsVisibility(hidden: true)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        setToolbarsVisibility(hidden: false)

        return memedImage
    }
    
    private func setToolbarsVisibility(hidden: Bool) {
        shareToolbar.isHidden = hidden
        imageToolbar.isHidden = hidden
    }
    
    func pickImage(_ sender: Any, sourceType: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        present(pickerController, animated: true, completion: nil)
        shareButton.isEnabled = true
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func setTextField(_ sender: UITextField, delegate: MemeTextDelegate) {
        sender.defaultTextAttributes = ViewController.memeTextAttributes
        sender.delegate = delegate
        sender.text = delegate.text
        sender.textAlignment = .center
        sender.autocapitalizationType = .allCharacters
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        let keyboardHeight = getKeyboardHeight(notification)
        if  (view.frame.origin.y ==  0 && bottomMemeDelegate.editing) {
            view.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if (view.frame.origin.y != 0) {
            view.frame.origin.y = 0
        }
    }
    
    func save(memedImage: UIImage) {
        // Create meme object
        let meme = Meme(topText: topWriting.text!, bottomText: bottomWriting.text!, originalImage: imagePicker.image!, memedImage: memedImage)
    }
    
}
