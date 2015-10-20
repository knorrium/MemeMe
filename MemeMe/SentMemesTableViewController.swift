//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Felipe Kuhn on 10/16/15.
//  Copyright © 2015 Knorrium. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        tableView.registerClass(SentMemesTableViewCell.self, forCellReuseIdentifier: "SentMemesTableViewCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDelegate.memes.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemesTableViewCell")!
        let meme = self.appDelegate.memes[indexPath.row]
        
        cell.textLabel?.text = meme.topText + " " + meme.bottomText
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("SentMemesDetailViewController") as! SentMemesDetailViewController

        detailController.memedImage = appDelegate.memes[indexPath.row].memedImage

        self.navigationController!.pushViewController(detailController, animated: true)
    }
}