//
//  TwitterClient.swift
//  Twitter
//
//  Created by Kun Rong on 9/28/14.
//  Copyright (c) 2014 Kun Rong. All rights reserved.
//

import UIKit

let twitterConsumerKey = "A2pnCveEey7xHxjSzSUaFdmU1"

let twitterConsumerSecret = "n8gyunYc6CUasRnBJrhUn29artvI55Nnw2DhovJtHLcprAS0gs"
let twitterBaseURL = NSURL(string: "https://api.twitter.com/" )

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
            }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("home_timeline: \(response)")
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            completion(tweets: tweets, error: nil)
        }, failure: { ( operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting to receive tweets")
                completion(tweets: nil, error: error)
        })
        
    }
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Fetch my request token and redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            println("Got the request token")
            println("\(requestToken.token)")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            println(authURL)
            UIApplication.sharedApplication().openURL(authURL)
            println("open url")
            } ) { (error: NSError!) -> Void in
                println("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
            fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
            
            println("Got access Token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation :AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                // print ("user: \(response)")
                
                var user = User(dictionary: response as NSDictionary)
                User.currentUser = user
                
                println("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            }) { (error: NSError!) -> Void in
                println("Failed to receive access Token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
}