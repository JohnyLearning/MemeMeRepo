//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Ivan Hadzhiiliev on 2020-01-19.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet var memsCollection: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memsCollection.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.memeImage?.image = meme.memedImage
        
        return cell
    }
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
       
       let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
       detailController.meme = self.memes[(indexPath as NSIndexPath).row]
       self.navigationController!.pushViewController(detailController, animated: true)
       
    }

}
