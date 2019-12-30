//
//  ViewController.swift
//  ImagePicker
//
//  Created by Ivan Hadzhiiliev on 2019-12-28.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topWriting: UITextField!
    @IBOutlet weak var bottomWriting: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var shareToolbar: UIToolbar!
    @IBOutlet weak var imageToolbar: UIToolbar!
    
    var memeObject: Meme?
    
    let topMemeDelegate = MemeTextDelegate(text: "TOP")
    let bottomMemeDelegate = MemeTextDelegate(text: "BOTTOM")
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.contentMode = UIView.ContentMode.scaleAspectFit
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = false
        setTextField(topWriting, delegate: topMemeDelegate)
        setTextField(bottomWriting, delegate: bottomMemeDelegate)
        setupToHideKeyboardOnTapOnView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func pickImageFromAlbum(_ sender: Any) {
        pickImage(sender, sourceType: .photoLibrary)
    }
    
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        pickImage(sender, sourceType: .camera)
    }
    
    @IBAction func shareImage(_ sender: Any) {
        let memeImage = generateMemedImage()
        let shareController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        
        shareController.popoverPresentationController?.sourceView = self.view

        self.present(shareController, animated: true, completion: nil)
    }
    
    private func pickImage(_ sender: Any, sourceType: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        present(pickerController, animated: true, completion: nil)
        shareButton.isEnabled = true
    }
    
    private func generateMemedImage() -> UIImage {

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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePicker.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setTextField(_ sender: UITextField, delegate: MemeTextDelegate) {
        sender.defaultTextAttributes = memeTextAttributes
        sender.delegate = delegate
        sender.text = delegate.text
        sender.textAlignment = .center
        sender.autocapitalizationType = .allCharacters
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if  (view.frame.origin.y ==  0) {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if (view.frame.origin.y != 0) {
            view.frame.origin.y = 0
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

}
