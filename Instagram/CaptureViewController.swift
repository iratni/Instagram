//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Youcef Iratni on 3/3/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, UITextFieldDelegate   {
    
    var resizedImage:UIImage!
    let imagePicker = UIImagePickerController()
    
    var image = UIImage()
    
    
    @IBOutlet weak var CapturedPic: UIImageView!
    @IBOutlet weak var TakeOrSelectButton: UIButton!
    @IBOutlet weak var writeCaptionTextField: UITextField!
    @IBOutlet weak var SubmitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        writeCaptionTextField.delegate = self
        imagePicker.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func TakeNewImage(sender: AnyObject) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        print("Image picker vc displayed")
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func OnSubmit(sender: AnyObject) {
        print("Submit button clicked")

        let newImage = resize(image, newSize: CGSize(width: 300, height: 500))
        InstagramShare.postUserImage(newImage, withCaption: writeCaptionTextField.text) { (success: Bool, error: NSError?) -> Void in
            
            if success {
                self.CapturedPic.image = nil
                self.writeCaptionTextField.text = nil
                self.tabBarController?.selectedIndex = 0
                print("image captured")
            } else {
                print("Couldn't post image to database")
            }
            
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func AddExistingImage(sender: AnyObject) {
       
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func saveToCamera(image: UIImage?) {
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            image = originalImage
            saveToCamera(image)
            dismissViewControllerAnimated(true, completion: nil)
            self.CapturedPic.image = image
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
        func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
