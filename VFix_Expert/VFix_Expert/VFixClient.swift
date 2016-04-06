//
//  VFixClient.swift
//  VFix_Expert
//
//  Created by Dustyn August on 3/24/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let vfixBaseUrl = NSURL(string: "http://104.197.177.20/api/v2/vfixmirror/_table/wp_postmeta?filter=post_id%20like%20'%25249%25")
let vfixConsumerKey = "36fda24fe5588fa4285ac6c6c2fdfbdb6b6bc9834699774c9bf777f706d05a88"
let vfixConsumerSecret = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsInVzZXJfaWQiOjEsImVtYWlsIjoibWFqaWQ4OHJhaGltaUBnbWFpbC5jb20iLCJmb3JldmVyIjpmYWxzZSwiaXNzIjoiaHR0cDpcL1wvMTA0LjE5Ny4xNzcuMjBcL2FwaVwvdjJcL3N5c3RlbVwvYWRtaW5cL3Nlc3Npb24iLCJpYXQiOjE0NTg4ODAxMzIsImV4cCI6MTQ1ODg4MzczMiwibmJmIjoxNDU4ODgwMTMyLCJqdGkiOiJiMGUwYzNhMTU0OTE4ODU4OWY2NmVmNTI0YWYxMWRmNSJ9.0JexRJhK4vAW53_8Waf4-dQecTw-1Ekd2uUikHs7v9o"



class VFixClient: BDBOAuth1SessionManager {
    
    //var loginCompleteion: (( user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: VFixClient {
        struct Static {
            static let instance = VFixClient(
                baseURL: vfixBaseUrl,
                consumerKey: vfixConsumerKey,
                consumerSecret: vfixConsumerSecret
            )
        }
        
        return Static.instance
    }
    
    // params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()
    
    func getTable(table_name: String) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.setValue(vfixConsumerKey, forHTTPHeaderField: "X-DreamFactory-Api-Key")
        manager.requestSerializer.setValue(vfixConsumerSecret, forHTTPHeaderField: "X-DreamFactory-Session-Token")
        manager.GET("http://104.197.177.20/api/v2/vfixmirror/_table/wp_posts", parameters: nil,
            success: {(operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                
                print("makeGet was successful!")
                print(response)
                
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("makeGet was a failure")
                print(error)
            }
        )
    }

}
    


