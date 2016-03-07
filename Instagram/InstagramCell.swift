//
//  InstagramCell.swift
//  Instagram
//
//  Created by Youcef Iratni on 3/2/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class InstagramCell: UITableViewCell {
    
    @IBOutlet weak var ProfilePictureImage: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var TimeStampLabel: UILabel!
    @IBOutlet weak var SharedPictureImage: PFImageView!
    @IBOutlet weak var CaptionAreaLabel: UILabel!
    
    var post: InstagramShare! {
        didSet {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MMM d, hh:mm a"
            TimeStampLabel.text = formatter.stringFromDate(post.createdAt!)
            
            let user = post.user
            
            if user != nil {
                UserNameLabel.text = user!.username
                
                if let imageFile = user!["picture"] as? PFFile {
                    do {
                        try ProfilePictureImage.image = UIImage(data: imageFile.getData())
                    } catch {
                    }
                }
            }
        }
    }
    
    var object: PFObject! {
        didSet {
            self.SharedPictureImage.file = object["media"] as? PFFile
            self.SharedPictureImage.loadInBackground()
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        UserNameLabel.text = PFUser.currentUser()!.username
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func GoToProfile(sender: AnyObject) {
      //  tabBarController?.selectedIndex = 2
        
    }
    
    

}
