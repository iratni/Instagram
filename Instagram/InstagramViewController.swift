//
//  InstagramViewController.swift
//  Instagram
//
//  Created by Youcef Iratni on 3/1/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//

import UIKit
import Parse
import TimeAgoInWords

class InstagramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    
    var posts: [PFObject]?
    var refreshControl: UIRefreshControl!
    var userToSend: PFUser?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UIScreen.mainScreen().bounds.width + 30

        
        let query = PFQuery(className: "InstagramShare")
        query.orderByDescending("createdAt")
        query.includeKey("_p_author")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                // print(posts)
                self.posts = posts
                self.tableView.reloadData()
            } else {
                print("Couldn't get Photo From Parse")
            }
        }
        
    tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let post = self.posts {
            return self.posts!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("InstagramCell", forIndexPath: indexPath) as! InstagramCell
        
        if (posts != nil) {
            let object = self.posts![indexPath.row]
            
            if object["caption"] != nil {
            let caption = object["caption"] as! String
            cell.CaptionAreaLabel.text = caption
            }
            let updatedAt = object.createdAt
            cell.TimeStampLabel.text = updatedAt!.timeAgoInWords()
            
            if object.objectForKey("profile_picture") != nil {
            let picture = object.objectForKey("profile_picture") as! PFFile
            picture.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
                if data != nil {
                    cell.ProfilePictureImage.image = UIImage(data: data!)
                }
            })
            } else {
                print("no profile pic")
            }
        
            cell.object = object
        }

        return cell;
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
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
