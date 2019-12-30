//
//  Meme.swift
//  MemeMe
//
//  Created by Ivan Hadzhiiliev on 2019-12-29.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    
    var topText: String?
    var bottomText: String?
    var originalImage: UIImage?
    var memedImage: UIImage?
    
    init(topText: String, bottomText: String, originalImage: UIImage?, memedImage: UIImage?) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
}
