//
//  RedactedBrain.swift
//  [Redacted]
//
//  Created by [Redacted] on [Redacted]-[Redacted]-[Redacted].
//  Copyright (c) 2015 [Redacted] All rights reserved.
//  THIS VERSION EXISTS SOLELY FOR /r/pokemondev
//

import Foundation

class RedactedBrain {
    private var prefixes: [String]
    private var redactedSuffixes: [String]
//    private var redacted2Suffix: String
//    private var redacted3Suffix: String
//    var redacted: (String, String)
    
    var dirty = false
    var savedRedacted: [String] = [""] {
        didSet {
            dirty = true
        }
        
    }
    // Define Constants
    let prefixValue = "Redacted"
    let suffixValue = "Redacted"
    let BASE_URL = "https://pastebin.com/raw.php?i="
    //            let prefixLink = "https://pastebin.com/raw.php?i=\(prefixValue)"
    //            let suffixLink = "https://pastebin.com/raw.php?i=\(suffixValue)"
    
//    func getListFromPastebin(pasteIdentifier: String) -> Array<String>{
//        var list: [String] = [""]
//        // API Arguments
//        let session = NSURLSession.sharedSession()
//        let urlString = BASE_URL + pasteIdentifier
//        let url = NSURL(string: urlString)!
//        let request = NSURLRequest(URL: url)
//        
//        // Initialize Task
//        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
//            if let error = downloadError {
//                println("Could not complete the request \(error)")
//            } else {
//                // Parse the data
//                if let pasteData = NSData(contentsOfURL: url) {
//                    dispatch_async(dispatch_get_main_queue(), {
//                    var pasteDataString = NSString(data:pasteData, encoding:NSUTF8StringEncoding)
//                    let pasteDataArray = pasteDataString?.componentsSeparatedByString(",") as! [String]
//                    list = pasteDataArray
//                    println("pasteData is \(pasteData)")
//                    println("pasteDataArray is \(pasteDataArray)")
//                    })
//                } else {
//                    println("Error 2: System Error Unknown")
//                    println("\(downloadError)")
//                }
//                println("Request completed")
//            }
//            println("Task completed")
//        }
//        println(list)
//        task.resume()
//        return list
//    }

    func getListFromPastebin(pasteIdentifier: String) -> Array<String> {
        let urlString = BASE_URL + pasteIdentifier
        let url = NSURL(string: urlString)!
        let pasteDataString: String?
        do {
            pasteDataString = try String(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        } catch _ {
            pasteDataString = nil
        }
        let pasteDataArray = pasteDataString?.componentsSeparatedByString(", ")
        let list = pasteDataArray
        return list!
    }
    init() {
        prefixes = ["Redacted", "Redacted", "Redacted", "Redacted", "Redacted", "Redacted", "Redacted"]
        redactedSuffixes = ["Redacted", "Redacted", "Redacted", "Redacted", "Redacted", "Redacted", "Redacted"]
        refreshListsFromInternet()
        
        
    }
    
    func refreshListsFromInternet() {
        if Reachability.isConnectedToNetwork() == true {
            
            prefixes = getListFromPastebin(prefixValue)
            redactedSuffixes = getListFromPastebin(suffixValue)
            
        } else if Reachability.isConnectedToNetwork() == false {
            prefixes = ["Redacted", "Redacted", "Redacted", "Redacted", "Redacted", "Redacted", "Redacted"]
            redactedSuffixes = ["Redacted", "Redacted", "Redacted", "Redacted", "Redacted", "Redacted", "Redacted"]
        }

    }
    private let prefix: String = ""
    private let suffix: String = ""
    
    func generatePrefixRedacted() -> String {
        let prefixValue = Int(arc4random_uniform(UInt32(prefixes.count)))
        let redactedPrefix = (prefixes[prefixValue])
        print(redactedPrefix)
        return redactedPrefix
        }
        
    func generateSuffixRedacted() -> String {
        let suffixValue = Int(arc4random_uniform(UInt32(redactedSuffixes.count)))
        let redactedSuffix = (redactedSuffixes[suffixValue])
        print(redactedSuffix)
        return redactedSuffix
        }
    
    
//    func sendSuffixList() -> [String] {
//        let suffixList = redactedSuffixes
//        return suffixList
//    }
//    
    func sendPrefixList() -> [[String]] {
        var prefixList = prefixes
        prefixList.insert("", atIndex: 0)
        let sentPrefixList = [prefixList]
        return sentPrefixList
    }
    
    func sendCombinedList() -> [[String]] {
        var suffixList = redactedSuffixes
        var prefixList = prefixes
        prefixList.insert("", atIndex: 0)
        suffixList.insert("", atIndex: 0)
        let combinedList = [prefixList,suffixList]
        return combinedList
    }
    
//    func showSavedList() -> String? {
//        return "".join(savedRedacted!.map{ "\($0)" })
//    }
    
//    func showSavedList() -> String? {
//        for element in savedRedacted {
//            
//        }
//    }
//    
    func showSavedList() -> String {
        return savedRedacted.joinWithSeparator("\n")
    }

}