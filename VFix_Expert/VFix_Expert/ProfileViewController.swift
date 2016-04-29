//
//  ProfileViewController.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 3/26/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import MMDrawerController
import SpriteKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var expertName: UILabel!
    @IBOutlet weak var expertPhoto: UIImageView!
    @IBOutlet weak var expertTopView: UIView!
    @IBOutlet weak var photoEditButton: UIButton!
    @IBOutlet weak var secureEditButton: UIButton!
    @IBOutlet weak var emailUnderlineView: UIView!
    @IBOutlet weak var invalidEmailLabel: UILabel!
    @IBOutlet weak var expertBottomView: UIView!
    @IBOutlet weak var expertBottomViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var expertBottomViewBottomConstraint: NSLayoutConstraint!
    
    
    var isUp: Bool = false
    var onSubmit: Bool = false
    let defaults = NSUserDefaults.standardUserDefaults()
    let lightSource = SKLightNode()
    // image in the future
    // services
    //a
    var firstName: String = "Noureddine"
    var lastName: String = "Youssfi"
    var firstTap = false
    
    @IBOutlet weak var mailPart1Field: UITextField!
    @IBOutlet weak var mailPart2Field: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var zipcodeField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var extensionField: UITextField!
    
    // Todo: collapse feature:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        
        let origImage = UIImage(named: "locked.ong")
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        secureEditButton.tintColor = UIColor.whiteColor()
        
        self.secureEditButton.setImage(tintedImage, forState: .Normal)
        print(emailUnderlineView.backgroundColor)
        navigationController?.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        if let imageData = userDefaults.objectForKey("image") as? NSData{
            if let img = UIImage(data: imageData){
                let size = CGSizeMake(64, 64)
                expertPhoto.image = imageResize(img, sizeChange: size)
            }
        } else {
            expertPhoto.image = UIImage(named: "myphoto64x64")
        }
        for subview in self.expertBottomView.subviews{
            if (subview != self.secureEditButton){
                subview.alpha = 0.5
                self.secureEditButton.alpha = 1
                self.expertBottomView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.6)
                
            }
        }
        expertPhoto.layer.borderWidth = 1
        expertPhoto.layer.masksToBounds = false
        expertPhoto.layer.borderColor = UIColor.whiteColor().CGColor
        expertPhoto.layer.cornerRadius = expertPhoto.frame.height/2
        expertPhoto.clipsToBounds = true
        expertTopView.backgroundColor = UIColor.blackColor()
        photoEditButton.hidden = true
        
        expertName.hidden = false
        expertName.text = firstName + " " + lastName
        
        
        mailPart1Field.enabled = false
        mailPart1Field.text = defaults.stringForKey("expert_mail_first")
        mailPart1Field.autocorrectionType = .No
        
        mailPart2Field.enabled = false
        mailPart2Field.text = defaults.stringForKey("expert_mail_second")
        mailPart2Field.autocorrectionType = .No
        
        phoneField.enabled = false
        phoneField.text = defaults.stringForKey("expert_phone")
        phoneField.autocorrectionType = .No
        
        emailField.enabled = false
        emailField.text = defaults.stringForKey("expert_email")
        emailField.autocorrectionType = .No
        invalidEmailLabel.hidden = true
        
        stateField.enabled = false
        stateField.text = defaults.stringForKey("state")
        stateField.autocorrectionType = .No
        
        zipcodeField.enabled = false
        zipcodeField.text = defaults.stringForKey("zip_code")
        zipcodeField.autocorrectionType = .No
        
        extensionField.enabled = false
        extensionField.text = defaults.stringForKey("ext")
        extensionField.autocorrectionType = .No
        
        

    
    }
//    deinit {
//        NSNotificationCenter.defaultCenter().removeObserver(self);
//    }
    func imageResize (image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    
    override func viewWillAppear(animated: Bool) {
        for subview in self.expertBottomView.subviews{
            if (subview != self.secureEditButton){
                subview.alpha = 0.5
                self.expertBottomView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.6)
                
            }
        }
//        secureEditButton.backgroundColor = UIColor.whiteColor()
//        secureEditButton.tintColor = UIColor.whiteColor()
        expertName.text = defaults.stringForKey("expert_name")
        emailField.text = defaults.stringForKey("expert_email")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    @IBAction func menuButtonTapped(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    @IBAction func editButtonClicked(sender: AnyObject) {
        chooseImage()
    }
    func chooseImage() {
        let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet);
        
        let takePhoto: UIAlertAction = UIAlertAction(title: "Take a Photo", style: .Default)
        { action -> Void in
            let vc = UIImagePickerController();
            vc.delegate = self;
            vc.allowsEditing = true;
            
            vc.sourceType = UIImagePickerControllerSourceType.Camera;
            vc.navigationBar.translucent = false
            vc.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
            vc.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
            vc.navigationBar.tintColor = UIColor.whiteColor()
            self.presentViewController(vc, animated: true, completion: nil);
        }
        actionSheet.addAction(takePhoto)
        
        let fromLibrary: UIAlertAction = UIAlertAction(title: "Choose Existing", style: .Default) { action -> Void in
            let vc = UIImagePickerController();
            vc.delegate = self;
            vc.allowsEditing = true;
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            vc.navigationBar.translucent = false
            vc.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
            vc.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
            vc.navigationBar.tintColor = UIColor.whiteColor()
            self.presentViewController(vc, animated: true, completion: nil);
        }
        actionSheet.addAction(fromLibrary)
        
        let cancelButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel)
        { action -> Void in
        }
        actionSheet.addAction(cancelButton)
        
        self.presentViewController(actionSheet, animated: true, completion: nil);
        
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            secureEditButton.tintColor = UIColor.redColor()
            let size = CGSize(width: 64,height: 64)
            expertPhoto.image = imageResize(editedImage,sizeChange: size)
            let ProfileJPEG: UIImage = expertPhoto.image!
            let ProfileJPG = UIImageJPEGRepresentation(ProfileJPEG, 1)! as NSData
            defaults.setObject(ProfileJPG, forKey: "image")
            defaults.synchronize()
            // Do something with the images (based on your use case)
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func secureEditClicked(sender: AnyObject) {
        var alert = UIAlertController(title: "Edit Info", message: "Enter Password:", preferredStyle: .Alert)
        if (!onSubmit){
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.secureTextEntry = true
                textField.placeholder = "Password"
                
            })
            
            //3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action) -> Void in
                let textField = alert.textFields![0] as UITextField
//                textField.layer.cornerRadius = 5
                print("Text field: \(textField.text)")
                
                
                self.secureEditButton.imageView?.image = UIImage(named: "unlocked.png")
                self.mailPart1Field.enabled = true
                self.mailPart2Field.enabled = true
                self.phoneField.enabled = true
                self.emailField.enabled = true
                self.zipcodeField.enabled = true
                self.stateField.enabled = true
                self.photoEditButton.hidden = false
                self.extensionField.enabled = true
                
//                self.secureEditButton.image = nil
//                self.secureEditButton.title = "Submit"
                self.onSubmit = true

                for subview in self.expertBottomView.subviews{
                    if (subview != self.secureEditButton){
                        UIView.animateWithDuration(0.5, animations: {
                            subview.alpha = 1
                            self.secureEditButton.alpha = 1
                            self.expertBottomView.backgroundColor = UIColor.whiteColor()
                        })
                    }
                }
//                UIView.animateWithDuration(0.7, animations: {
//                    self.expertBottomViewTopConstraint.constant = 40
//                })
//                self.secureEditButton.backgroundColor = UIColor.whiteColor()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                print("Canceled")
                self.onSubmit = false
            }))
            
           
            
            // 4. Present the alert.
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            onSubmit = false
            let origImage = UIImage(named: "locked.ong")
            let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            secureEditButton.tintColor = UIColor.whiteColor()
            
            self.secureEditButton.setImage(tintedImage, forState: .Normal)
            for subview in self.expertBottomView.subviews{
                if (subview != self.secureEditButton){
                    UIView.animateWithDuration(0.5, animations: {
                        subview.alpha = 0.5
                        self.secureEditButton.alpha = 1
                        self.expertBottomView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.6)
                    })
                }
            }

            mailPart1Field.enabled = false
            mailPart2Field.enabled = false
            phoneField.enabled = false
            emailField.enabled = false
            zipcodeField.enabled = false
            stateField.enabled = false
            extensionField.enabled = false
            expertBottomViewTopConstraint.constant = 168
            
            self.photoEditButton.hidden = true
            
            defaults.setObject(extensionField.text, forKey: "ext")
            defaults.setObject(mailPart1Field.text, forKey: "expert_mail_first")
            defaults.setObject(mailPart2Field.text, forKey: "expert_mail_second")
            defaults.setObject(phoneField.text, forKey: "expert_phone")
            defaults.setObject(emailField.text, forKey: "expert_email")
            defaults.setObject(stateField.text, forKey: "state")
            defaults.setObject(zipcodeField.text, forKey: "zip_code")
            defaults.synchronize()
//            defaults.setObject(expertName.text, forKey: "expert_name")
//            defaults.setObject(expertName.text, forKey: "expert_name")
            
            
        }
    }
    @IBAction func onEmailChanged(sender: AnyObject) {
        textFieldDidBeginEditing(emailField)
        if (!isValidEmail(emailField.text!)){
            emailUnderlineView.backgroundColor = UIColor.redColor()
            invalidEmailLabel.hidden = false
        } else {
            emailUnderlineView.backgroundColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
            invalidEmailLabel.hidden = true
            // 0.0784314 0.615686 0.917647
        }
    }
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }

    @IBAction func supportButtonClicked(sender: AnyObject) {
        let suppVC = self.storyboard!.instantiateViewControllerWithIdentifier("SupportViewController") as! SupportViewController
        let navController = UINavigationController(rootViewController: suppVC) // Creating a navigation controller with VC1 at the root of the navigation stack.
        self.presentViewController(navController, animated:true, completion: nil)
    }
    // phone 110
    // email
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onSecuredTap(sender: AnyObject) {
        if (!onSubmit){
            if (!firstTap){
                firstTapValidation()
            } else {
                securityAnimationWithDuration(0.2)
            }
        }
    }
    
    func firstTapValidation(){
        firstTap = true
        var refreshAlert = UIAlertController(title: "Security Alert", message: "Please verify your account.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            self.securityAnimationWithDuration(0.7)
            }))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    func securityAnimationWithDuration(duration : NSTimeInterval){
            self.secureEditButton.imageView?.image = nil
            let origImage = UIImage(named: "locked.ong")
            let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.secureEditButton.tintColor = UIColor.redColor()
            
            self.secureEditButton.setImage(tintedImage, forState: .Normal)
            UIView.animateWithDuration(duration, animations: {
                self.secureEditButton.transform = CGAffineTransformMakeScale(3, 3)
            })
            UIView.animateWithDuration(duration, animations: {
                self.secureEditButton.transform = CGAffineTransformMakeScale(1, 1)
            })
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch textField {
        case mailPart1Field:
            self.expertBottomViewTopConstraint.constant = 40
            break
        case mailPart2Field:
            self.expertBottomViewTopConstraint.constant = 40
            break
        case stateField:
            self.expertBottomViewTopConstraint.constant = 40
            break
        case zipcodeField:
            self.expertBottomViewTopConstraint.constant = 40
            break
        case extensionField:
            self.expertBottomViewTopConstraint.constant = 40
            break
        case emailField:
            self.expertBottomViewTopConstraint.constant = 40
            break
        case phoneField:
            self.expertBottomViewTopConstraint.constant = 40
            break
        default:
            self.expertBottomViewTopConstraint.constant = 40
        }
    }
    @IBAction func onMail1Changed(sender: AnyObject) {
        textFieldDidBeginEditing(mailPart1Field)
    }
    @IBAction func onMail2Changed(sender: AnyObject) {
        textFieldDidBeginEditing(mailPart1Field)
    }
    @IBAction func onStateChanged(sender: AnyObject) {
        textFieldDidBeginEditing(stateField)
    }
    @IBAction func onZipChanged(sender: AnyObject) {
        textFieldDidBeginEditing(zipcodeField)
    }
    @IBAction func onExtChanged(sender: AnyObject) {
        textFieldDidBeginEditing(extensionField)
    }
    @IBAction func onPhoneChanged(sender: AnyObject) {
        textFieldDidBeginEditing(phoneField)
    }
//    func keyboardWasShown(notification: NSNotification) {
//        var info = notification.userInfo!
//        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//        
//        UIView.animateWithDuration(0.1, animations: { () -> Void in
//            self.expertBottomViewBottomConstraint.constant = 40
//        })
//    }
    
    // phone 50
    // email 50
    // state zip ext
    
    
    
}

