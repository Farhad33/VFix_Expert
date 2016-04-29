//
//  LoginViewController.swift
//  VFix_Expert
//
//  Created by Dustyn August on 3/10/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import ARSLineProgress

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var textButtonBar: UIView!
    @IBOutlet weak var fieldRequired: UILabel!
    @IBOutlet weak var fieldRequired2: UILabel!
    @IBOutlet weak var passwordBar: UIView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var seperateSignIn: UIButton!
    @IBOutlet weak var mainSignin: UIButton!
    @IBOutlet weak var signinView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    var passlength = false
    var triedSigningin = false
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        
        super.viewDidLoad()
        passlength = false
        triedSigningin = false
//        self.view.bringSubviewToFront(signinView)
        fieldRequired.hidden = true
        usernameField.autocorrectionType = .No
        fieldRequired2.hidden = true
        usernameField.returnKeyType = .Done
//        usernameField.keyboardAppearance = UIKeyboardAppearance.Alert
        passwordField.returnKeyType = .Go
        usernameField.delegate = self
        passwordField.delegate = self
        seperateSignIn.layer.cornerRadius = 5
        cancelButton.layer.cornerRadius = 5
        mainSignin.layer.cornerRadius = 5
        signinView.layer.cornerRadius = 5
        if let username = userDefaults.objectForKey("user_name"){
            usernameField.text = username as! String
        }
        self.signinView.hidden = true
//        self.signinView.userInteractionEnabled = true
//        signinView.center.x = super.view.center.x
        passwordField.text = ""
        passwordField.secureTextEntry = true
        // Do any additional setup after loading the view.
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    override func viewWillAppear(animated: Bool) {
        passlength = false
        triedSigningin = false
        usernameField.autocorrectionType = .No
        self.signinView.hidden = true
        for subview in self.view.subviews{
            if (subview != self.signinView){
                subview.alpha = 1.0
                self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(1.0)
                
            }
        }
        passwordField.text = ""
        passwordField.secureTextEntry = true
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    override func viewWillDisappear(animated: Bool) {
        passlength = false
        triedSigningin = false
        usernameField.autocorrectionType = .No
        self.signinView.hidden = true
//        passwordField.text = ""
//        passwordField.secureTextEntry = true
        for subview in self.view.subviews{
            if (subview != self.signinView){
                subview.alpha = 1.0
                self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(1.0)
                
            }
        }
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == usernameField){
            passwordField.becomeFirstResponder()
        }else {
            authentificationValidation()
        }
        return true
    }
    @IBAction func onSignIn(sender: AnyObject) {
        triedSigningin = true
        authentificationValidation()
        
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
        if passwordField.text == "" && triedSigningin{
            passwordBar.backgroundColor = UIColor.redColor()
            fieldRequired2.hidden = false
            fillAllrequired()
            return false
            
        }else if passwordField.text?.characters.count < 6 && triedSigningin{
            passwordBar.backgroundColor = UIColor.redColor()
            fieldRequired2.hidden = false
            passlength = false
            passlengthValidation()
            return false
            
        } else {
            passwordBar.backgroundColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
            fieldRequired2.hidden = true
            passlength = true
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
    
    func authentificationValidation(){
        if (usernameValidation() && passwordValidation()){
            userDefaults.setObject(usernameField.text, forKey: "user_name")
            ARSLineProgress.showSuccess()
            
            let seconds = 1.5
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                
                // here code perfomed with delay
                self.appDelegate.buildInterface()
            })
            
            
        } else {
            if (passlength){
                fillAllrequired()
            }
        }
    }
    func fillAllrequired(){
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
    @IBAction func mainSigninClicked(sender: AnyObject) {
        
        
        UIView.animateWithDuration(0.5, animations: {
            self.signinView.hidden = false
            for subview in self.view.subviews{
                if (subview != self.signinView){
                    subview.alpha = 0.5
                    self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.6)
                    
                }
            }
            
            
        })
        if (usernameField.text == ""){
            usernameField.becomeFirstResponder()
        } else {
            passwordField.becomeFirstResponder()
        }
        //self.view.bringSubviewToFront(signinView)
        
        
        
    }
    
    @IBAction func onCancelClicked(sender: AnyObject) {
        hidesigninView()
    }
    @IBAction func viewOnTap(sender: AnyObject) {
        hidesigninView()
    }
    func passlengthValidation(){
        var refreshAlert = UIAlertController(title: "Log in", message: "Password must be at least 6 Characters long!", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            self.signinView.hidden = false
            self.passwordField.becomeFirstResponder()
            
        }))
        
        //            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
        //                print("Canceled")
        //            }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    func hidesigninView(){
        triedSigningin = false
        UIView.animateWithDuration(0.5, animations: {
            self.signinView.hidden = true
            for subview in self.view.subviews{
                if (subview != self.signinView){
                    subview.alpha = 1.0
                    self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(1.0)
                    
                }
            }
            self.view.endEditing(true)
            self.passwordBar.backgroundColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
            self.fieldRequired.hidden = true
            self.passwordField.text = ""
            self.fieldRequired2.hidden = true
            self.textButtonBar.backgroundColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        })
        
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
