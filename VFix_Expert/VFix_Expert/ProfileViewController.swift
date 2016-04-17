//
//  ProfileViewController.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 3/26/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import MMDrawerController

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var expertName: UILabel!
    @IBOutlet weak var expertPhoto: UIImageView!
    @IBOutlet weak var expertTopView: UIView!
    @IBOutlet weak var photoEditButton: UIButton!
    @IBOutlet weak var secureEditButton: UIBarButtonItem!
    
    var isUp: Bool = false
    var onSubmit: Bool = false
    let defaults = NSUserDefaults.standardUserDefaults()
    // image in the future
    // services
    //a
    var firstName: String = "Noureddine"
    var lastName: String = "Youssfi"
    
    
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
        navigationController?.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
//        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        expertPhoto.image = UIImage(named: "myphoto64x64")
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
        
        mailPart2Field.enabled = false
        mailPart2Field.text = defaults.stringForKey("expert_mail_second")
        
        phoneField.enabled = false
        phoneField.text = defaults.stringForKey("expert_phone")
        
        emailField.enabled = false
        emailField.text = defaults.stringForKey("expert_email")
        
        stateField.enabled = false
        stateField.text = defaults.stringForKey("state")
        
        zipcodeField.enabled = false
        zipcodeField.text = defaults.stringForKey("zip_code")
        
        extensionField.enabled = false
        extensionField.text = defaults.stringForKey("ext")
        
        // expertBottomView.center.y = self.view.bounds.height + expertBottomView.center.y
//        self.expertBottomView.center.y = self.view.bounds.height / 1.14
        // Do any additional setup after loading the view.
//        photoEditButton.layer.borderWidth = 1
//        photoEditButton.layer.masksToBounds = false
//        photoEditButton.layer.borderColor = UIColor.whiteColor().CGColor
//        photoEditButton.layer.cornerRadius = photoEditButton.frame.height/2
//        photoEditButton.clipsToBounds = true

        
    }
    
    override func viewWillAppear(animated: Bool) {
        
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
            
            
            expertPhoto.image = editedImage
            
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
                
                print("Text field: \(textField.text)")
                
                
                self.mailPart1Field.enabled = true
                self.mailPart2Field.enabled = true
                self.phoneField.enabled = true
                self.emailField.enabled = true
                self.zipcodeField.enabled = true
                self.stateField.enabled = true
                self.photoEditButton.hidden = false
                self.extensionField.enabled = true
                self.secureEditButton.image = nil
                self.secureEditButton.title = "Submit"
                self.onSubmit = true
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                print("Canceled")
                self.onSubmit = false
            }))
            
           
            
            // 4. Present the alert.
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            onSubmit = false
            
            mailPart1Field.enabled = false
            mailPart2Field.enabled = false
            phoneField.enabled = false
            emailField.enabled = false
            zipcodeField.enabled = false
            stateField.enabled = false
            extensionField.enabled = false
            
            self.photoEditButton.hidden = true
            self.secureEditButton.title = ""
            self.secureEditButton.image = UIImage(named: "editbutton.png")
            
            /*
            @IBOutlet weak var mailPart1Field: UITextField!
            @IBOutlet weak var mailPart2Field: UITextField!
            @IBOutlet weak var phoneField: UITextField!
            @IBOutlet weak var emailField: UITextField!
            */
            
            /*
            mailPart1Field.text = defaults.stringForKey("expert_mail_part1")
            
            mailPart2Field.enabled = false
            mailPart1Field.text = defaults.stringForKey("expert_mail_part2")
            */
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


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
