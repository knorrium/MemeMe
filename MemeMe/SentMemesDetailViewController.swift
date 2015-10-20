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
    var savedIndex: Int!
    
    @IBOutlet var imageView: UIImageView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: Selector("editMeme"))
        imageView.image = memedImage
        tabBarController?.tabBar.hidden = false
    }
    
    func editMeme() {
        if navigationItem.rightBarButtonItem!.title == "Edit" {
            navigationItem.rightBarButtonItem!.title = "Done"
            let editController = storyboard!.instantiateViewControllerWithIdentifier("EditMemeViewcontroller") as! ViewController
            editController.savedIndex = savedIndex

            tabBarController?.tabBar.hidden = true
            navigationController!.pushViewController(editController, animated: true)
        }
        else {
            navigationItem.rightBarButtonItem!.title = "Edit"
            tabBarController?.tabBar.hidden = false
        }

    }
    
}