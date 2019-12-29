//
//  ViewController.swift
//  Click Counter
//
//  Created by Ivan Hadzhiiliev on 2019-12-04.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count = 0
    var label: UILabel!
    var label2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let label = UILabel()
        label.frame = CGRect(x: 150, y:150, width: 60, height: 60)
        label.text = "0"
        view.addSubview(label)
        self.label = label
        
        self.label2 = UILabel()
        self.label2.frame = CGRect(x: 300, y: 150, width: 60, height: 60)
        self.label2.text = "0"
        view.addSubview(self.label2)
        
        let incrementButton = UIButton()
        incrementButton.frame = CGRect(x: 150, y:250, width: 60, height: 60)
        incrementButton.setTitle("Inc", for: .normal)
        incrementButton.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(incrementButton)
        incrementButton.addTarget(self, action: #selector(ViewController.incrementCount), for: UIControl.Event.touchUpInside)
        
        let decrementButton = UIButton()
        decrementButton.frame = CGRect(x: 300, y:250, width: 60, height: 60)
        decrementButton.setTitle("Dec", for: .normal)
        decrementButton.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(decrementButton)
        decrementButton.addTarget(self, action: #selector(ViewController.decrementCount), for: UIControl.Event.touchUpInside)
    }
    
    @objc func incrementCount() {
        self.count += 1
        self.label.text = "\(self.count)"
        self.label2.text = "\(self.count)"
        view.backgroundColor = UIColor.white
    }
    
    @objc func decrementCount() {
        self.count -= 1
        self.label2.text = "\(self.count)"
        view.backgroundColor = UIColor.blue
    }


}

