//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON


class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    // sozdaem obekt klasa TweetSentimentClassifier modelMl
    let sentimentClassifier = TweetSentimentClassifier()
    let tweetCount = 100
    
    // Instantiation using Twitter's OAuth Consumer Key and secret
    let swifter = Swifter(consumerKey: "my personal API consumerKey", consumerSecret: "my personal API consumerSecret")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        
        fetchTweets()
        
    }
    
    func fetchTweets() {
        if let searchText = textField.text {
            
            
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended, success: { (results, metadata) in
                print(results)
                // pomes4aem poly4enue rezyltatu niže w etot masiw
                var tweets = [TweetSentimentClassifierInput] ()
                
                for i in 0..<self.tweetCount {
                    // izwlekaem perwuj koment
                    if let tweet = results[i]["full_text"].string {
                        //print(tweet)
                        
                        // peredeluwaem string w format TweetSentimentClassifierInput
                        let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                
                self.makePrediction(with: tweets)
                
            }) { (error) in
                print("There was an error with the Twitter API Request< \(error)")
            }
            
            
        }
        
        
    }
    
    func makePrediction(with tweets: [TweetSentimentClassifierInput]) {
        // dobawliaem masiw s dannumi dlia analiza nastrienija w priloženii
        do {
            
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            
            var sentimentScore = 0
            
            for pred in predictions {
                let sentiment = pred.label
                
                if sentiment == "Pos" {
                    sentimentScore += 1
                }else if sentiment == "Neg" {
                    sentimentScore -= 1
                }
            }
            updateUI(wiht: sentimentScore)
            print(sentimentScore)
        }catch{
            print("There was an error with making a prediction, \(error)")
        }
        
    }
    
    func updateUI(wiht sentimentScore: Int) {
        // proweriaem otnoshenije polzowatelej
        if sentimentScore > 20 {
            self.sentimentLabel.text = "😍"
        } else if sentimentScore > 10 {
            self.sentimentLabel.text = "😀"
        } else if sentimentScore > 0 {
            self.sentimentLabel.text = "🙂"
        } else if sentimentScore == 0 {
            self.sentimentLabel.text = "😐"
        } else if sentimentScore > -10 {
            self.sentimentLabel.text = "😕"
        } else if sentimentScore > -20 {
            self.sentimentLabel.text = "😡"
        } else {
            self.sentimentLabel.text = "🤮"
        }
    }
}

