//
//  LoginViewController.swift
//  VFix_Expert
//
//  Created by Dustyn August on 3/10/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var textButtonBar: UIView!
    @IBOutlet weak var fieldRequired: UILabel!
    @IBOutlet weak var fieldRequired2: UILabel!
    @IBOutlet weak var passwordBar: UIView!
    @IBOutlet weak var passwordField: UITextField!
    
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fieldRequired.hidden = true
        fieldRequired2.hidden = true
        if let username = userDefaults.objectForKey("user_name"){
            usernameField.text = username as! String
        }
        passwordField.text = ""
        passwordField.secureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        passwordField.text = ""
        passwordField.secureTextEntry = true
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    override func viewWillDisappear(animated: Bool) {
//        passwordField.text = ""
//        passwordField.secureTextEntry = true
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func onSignIn(sender: AnyObject) {
        if (usernameValidation() && passwordValidation()){
            userDefaults.setObject(usernameField.text, forKey: "user_name")
            appDelegate.buildInterface()
        } else {
            var refreshAlert = UIAlertController(title: "Log in", message: "Please fill all required fields!", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                if (!self.usernameValidation()){
                    self.usernameField.becomeFirstResponder()
                }else {
                    self.passwordField.becomeFirstResponder()
                }
            }))
            
//            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
//                print("Canceled")
//            }))
            presentViewController(refreshAlert, animated: true, completion: nil)
        }
        
    }
    @IBAction func onSignUpClicked(sender: AnyObject) {
        self.userDefaults.setObject(nil, forKey: "user_name")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpViewController") as! SignUpViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    @IBAction func onUsernameChanged(sender: AnyObject) {
        usernameValidation()
    }

    @IBAction func onPasswordChanged(sender: AnyObject) {
        passwordValidation()
    }
    
    func passwordValidation() -> Bool{
        if passwordField.text == ""{
            passwordBar.backgroundColor = UIColor.redColor()
            fieldRequired2.hidden = false
            return false
            
        } else {
            passwordBar.backgroundColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
            fieldRequired2.hidden = true
            return true
        }
    }
    func usernameValidation() -> Bool{
        if usernameField.text == ""{
            textButtonBar.backgroundColor = UIColor.redColor()
            fieldRequired.hidden = false
            return false
            
        } else {
            textButtonBar.backgroundColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
            fieldRequired.hidden = true
            return true
        }
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
