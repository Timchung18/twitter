//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Timothy Cheung on 2/4/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArr = [Tweet]()
    var numberOfTweet: Int!
    
    let myRefreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadTweet()
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweet()
        
    }

    @objc func loadTweet(){
        let myUrl = TweetBaseUrl.LoadTweet.rawValue
        let myParams = ["count": 20]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArr.removeAll()
            for tweet in tweets{
                
                let user = tweet["user"] as! NSDictionary
                let content = tweet["text"] as! String
                let id = tweet["id"] as! Int
                let fav = tweet["favorited"] as! Bool
                let retweet = tweet["retweeted"] as! Bool
                
                let aTweet = Tweet(user: user, tweetContent: content, tweetId: id, favorited: fav, retweeted: retweet)
                self.tweetArr.append(aTweet)
                
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("Could not retrieve tweets")
        })
    }

    @IBAction func onLogout(_ sender: Any) {
        
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.tweetCell.rawValue, for: indexPath) as! TweetCellTableViewCell
        let aTweet = tweetArr[indexPath.row]
        let user = aTweet.user
        
        cell.userNameLabel.text = user["name"] as! String
        
        cell.tweetContentLabel.text = aTweet.tweetContent
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        cell.tweetId = aTweet.tweetId
        cell.setFavorite(aTweet.favorited)
        cell.setRetweeted(aTweet.retweeted)
        return cell
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArr.count
    }

    

}
