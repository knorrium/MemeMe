//
//  ViewController.swift
//  MemeMe
//
//  Created by Felipe Kuhn on 9/27/15.
//  Copyright © 2015 Knorrium. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var galleryButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pickImageFromGallery(sender: UIBarButtonItem) {
        NSLog("Gallery")
        
    }
    
    
    @IBAction func pickImageFromCamera(sender: UIBarButtonItem) {
        NSLog("Camera")
    }
}

