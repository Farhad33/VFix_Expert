//
//  LoginViewController.swift
//  VFix_Expert
//
//  Created by Dustyn August on 3/10/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var twitterButtonView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logInBUtton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                    message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK",style: UIAlertActionStyle.Default, handler: nil))
            } else {
                NSLog("Login error: %@", error!.localizedDescription)
            }
        }
        // TODO: Change where the log in button is positioned in your view
        logInBUtton.center = self.twitterButtonView.center
        self.view.addSubview(logInBUtton)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
