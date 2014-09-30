//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Kun Rong on 9/28/14.
//  Copyright (c) 2014 Kun Rong. All rights reserved.
//

import UIKit

@objc protocol TweetsViewControllerDelegate {
    func showTweetsDetail(tw tweetobj:Tweet)
}

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var NavigationBar: UINavigationItem!
    @IBOutlet weak var signOut: UIBarButtonItem!
    @IBOutlet weak var newButton: UIBarButtonItem!
    var tweets: [Tweet]?
    weak var delegate: TweetsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("tweetTableCell") as tweetTableViewCell
        
        //tableView.rowHeight = UITableViewAutomaticDimension
        if tweets != nil {
            if tweets?.count > indexPath.row {
                var tweet = tweets![indexPath.row] as Tweet
                var user = tweet.user! as User
                var profile_image = user.profileImageUrl
                var username = user.name
                var text_field = tweet.text
                var created_at = tweet.createdAtString
                
                cell.profile_image.setImageWithURL(NSURL(string: profile_image!))
                cell.username.text = username
                cell.tweet_text.text = text_field
                cell.created_At.text = created_at
            }
        }
        tableView.rowHeight = UITableViewAutomaticDimension
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("___________select:\(indexPath.row)")
        var tweet = tweets![indexPath.row] as Tweet
        delegate?.showTweetsDetail(tw: tweet)
        performSegueWithIdentifier("detailTweet", sender: self)
    }
    
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
