//
//  ViewController.swift
//  MemeMe
//
//  Created by Felipe Kuhn on 9/27/15.
//  Copyright © 2015 Knorrium. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var galleryButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!

    weak var editingField: UITextField!
    var memedImage: UIImage!
    
    var meme:Meme!
    
    var defaultTopText = "TOP TEXT"
    var defaultBottomText = "BOTTOM TEXT"
    
    var savedIndex: Int? = nil
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -4,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        shareButton.enabled = false
        subscribeToKeyboardNotifications()
    }

    override func viewWillAppear(animated: Bool) {
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes

        topText.textAlignment = NSTextAlignment.Center
        bottomText.textAlignment = NSTextAlignment.Center
        
        topText.delegate = self
        bottomText.delegate = self
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // TODO: Refactor to a common method
    @IBAction func pickImageFromGallery(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            shareButton.enabled = true
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        // Clear the text field if it's filled with the default value
        editingField = textField
        
        if (textField == topText && editingField.text == defaultTopText) {
            textField.text = ""
        }
        
        if (textField == bottomText && editingField.text == defaultBottomText) {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        // Reset the value of the TextField in case it becomes empty
        if (textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "") {
            if (textField == topText) {
                textField.text = defaultTopText
            } else {
                textField.text = defaultBottomText
            }
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if (editingField == bottomText) {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func save() {
        //Create the meme
        memedImage = generateMemedImage()
        meme = Meme(
            topText: topText.text!,
            bottomText: bottomText.text!,
            image: imageView.image!,
            memedImage: memedImage)
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }

    func generateMemedImage() -> UIImage {
        
        toolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let newImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolbar.hidden = false
        
        return newImage
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        save()
        let ShareVC = UIActivityViewController(activityItems:[memedImage], applicationActivities: nil)
        presentViewController(ShareVC, animated: true, completion: nil)
    }
}

