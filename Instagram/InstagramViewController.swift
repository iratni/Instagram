//
//  InstagramViewController.swift
//  Instagram
//
//  Created by Youcef Iratni on 3/1/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//

import UIKit

class InstagramViewController: UIViewController {
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        self.performSegueWithIdentifier("logOutSegue", sender: nil)
        print("You're Logged Out ")
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
