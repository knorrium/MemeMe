//
//  SentMemesDetailViewController.swift
//  MemeMe
//
//  Created by Felipe Kuhn on 10/16/15.
//  Copyright © 2015 Knorrium. All rights reserved.
//

import Foundation
import UIKit

class SentMemesDetailViewController: UIViewController {
    var memedImage: UIImage!
    
    @IBOutlet var imageView: UIImageView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = memedImage
    }
    
}