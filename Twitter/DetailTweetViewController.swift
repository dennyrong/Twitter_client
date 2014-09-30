//
//  DetailTweetViewController.swift
//  Twitter
//
//  Created by Kun Rong on 9/28/14.
//  Copyright (c) 2014 Kun Rong. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController, TweetsViewControllerDelegate {
    
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var tweet_text: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var retweet: UILabel!
    @IBOutlet weak var favorates: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("nanihaha")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      //  if segue.identifier == "detailTweet" {
            println("ahsdhsad")
        //}
        //var TweetsView = segue.sourceViewController as TweetsViewController
        //TweetsView.delegate = self
    }
    
    func showTweetsDetail(tw tweetobj:Tweet) {
        println("!!!!!!!!!!")
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
