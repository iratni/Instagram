//
//  InstagramShare.swift
//  Instagram
//
//  Created by Youcef Iratni on 3/2/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//

import UIKit
import Parse

class InstagramShare: NSObject {
    
    
    var user: PFUser?
    var image: UIImage?
    var caption: String?
    var createdAt: NSDate?

    
    
    var author: String?
    var timestamp: String?
    var commentsCount: Int?
    var likesCount: Int?
    var media: PFFile?
    
    init(object: PFObject) {
        super.init()
        
        media = object["media"] as? PFFile
        caption = object["caption"] as? String
        author = object["author"] as? String
        let timeStamp = object["_created_at"] as? String
        commentsCount = object["commentsCount"] as? Int
        likesCount = object["likesCount"] as? Int
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let createdAt = formatter.dateFromString(timeStamp!)
        timestamp = "\(String(Int(NSDate().timeIntervalSinceDate(createdAt!))))" as String
    }
    
    
    
    
    
    class func postUserImage(image: UIImage?, withCaption caption: String? , withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "InstagramShare")
        
        if image == nil {
            return
        }
        post["media"] = getPFFileFromImage(image!)
        post["author"] = PFUser.currentUser()
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
       
        
        post.saveInBackgroundWithBlock(completion)
    }
    
    
    class func postProfileImage(image: UIImage?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "InstagramShare")
        
        if image == nil {
            return
        }
        post["profile_picture"] = getPFFileFromImage(image!)
        post["author"] = PFUser.currentUser()
        post.saveInBackgroundWithBlock(completion)
    }
    
    
    
    class func getPFFileFromImage(image:UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    
    


}
