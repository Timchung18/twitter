//
//  Enums.swift
//  Twitter
//
//  Created by Timothy Cheung on 2/11/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import Foundation
enum Cell: String {
    case tweetCell
}

enum TweetBaseUrl: String {
    case LoadTweet = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    case BaseUrl = "https://api.twitter.com"
    case PostUpdate = "https://api.twitter.com/1.1/statuses/update.json"
    case FavTweet = "https://api.twitter.com/1.1/favorites/create.json"
    case UnfavTweet = "https://api.twitter.com/1.1/favorites/destroy.json"
    case RetweetPart1 = "https://api.twitter.com/1.1/statuses/retweet/"
    case Authorize = "https://api.twitter.com/oauth/authorize?oauth_token="
}
