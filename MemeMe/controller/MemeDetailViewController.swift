//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Ivan Hadzhiiliev on 2020-01-19.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!

    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.memeImageView?.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func shareImage(_ sender: Any) {
        let memeImage = meme?.memedImage
        let shareController = UIActivityViewController(activityItems: [memeImage as Any], applicationActivities: nil)
        
        shareController.popoverPresentationController?.sourceView = self.view
        
        shareController.completionWithItemsHandler = { activity, success, items, error in
            if success  {
                self.navigationController?.popViewController(animated: true)
            }
        }
        self.present(shareController, animated: true, completion: nil)
    }

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editMeme(_ sender: Any) {
        let editController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        editController.meme = meme
        self.navigationController!.pushViewController(editController, animated: true)
    }
    
}
