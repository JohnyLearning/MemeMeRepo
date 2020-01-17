//
//  ViewController.swift
//  ImagePicker
//
//  Created by Ivan Hadzhiiliev on 2019-12-28.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    static let TOP_WRITING_INITAL_TEXT = "TOP"
    static let BOTTOM_WRITING_INITAL_TEXT = "BOTTOM"
    
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topWriting: UITextField!
    @IBOutlet weak var bottomWriting: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var shareToolbar: UIToolbar!
    @IBOutlet weak var imageToolbar: UIToolbar!
    
    var memeObject: Meme?
    
    var topMemeDelegate = MemeTextDelegate(text: MemeEditorViewController.TOP_WRITING_INITAL_TEXT)
    var bottomMemeDelegate = MemeTextDelegate(text: MemeEditorViewController.BOTTOM_WRITING_INITAL_TEXT)
    
    static let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        shareController.completionWithItemsHandler = { activity, success, items, error in
            if success  {
                self.save(memedImage: memeImage)
            }
        }

        self.present(shareController, animated: true, completion: nil)
    }
    
    @IBAction func reset(_ sender: Any) {
        imagePicker.image = nil
        topWriting.text = MemeEditorViewController.TOP_WRITING_INITAL_TEXT
        bottomWriting.text = MemeEditorViewController.BOTTOM_WRITING_INITAL_TEXT
        shareButton.isEnabled = false
    }
    
}
