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
    @IBOutlet weak var expertBottomView: UIView!
    @IBOutlet weak var photoEditButton: UIButton!
    @IBOutlet weak var secureEditButton: UIBarButtonItem!
    
    var isUp: Bool = false
    var onSubmit: Bool = false
    // image in the future
    // services
    //a
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var mailPart1Field: UITextField!
    @IBOutlet weak var mailPart2Field: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    // Todo: collapse feature:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
//        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        expertPhoto.image = UIImage(named: "myphoto64x64")
        expertPhoto.layer.borderWidth = 1
        expertPhoto.layer.masksToBounds = false
        expertPhoto.layer.borderColor = UIColor.blackColor().CGColor
        expertPhoto.layer.cornerRadius = expertPhoto.frame.height/2
        expertPhoto.clipsToBounds = true
        expertTopView.backgroundColor = UIColor.blackColor()
        photoEditButton.hidden = true
        expertName.hidden = true
        
        firstNameField.enabled = false
        lastNameField.enabled = false
        mailPart1Field.enabled = false
        mailPart2Field.enabled = false
        phoneField.enabled = false
        emailField.enabled = false
        // expertBottomView.center.y = self.view.bounds.height + expertBottomView.center.y
//        self.expertBottomView.center.y = self.view.bounds.height / 1.14
        // Do any additional setup after loading the view.
//        photoEditButton.layer.borderWidth = 1
//        photoEditButton.layer.masksToBounds = false
//        photoEditButton.layer.borderColor = UIColor.whiteColor().CGColor
//        photoEditButton.layer.cornerRadius = photoEditButton.frame.height/2
//        photoEditButton.clipsToBounds = true

        
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
        if !isUp{
            UIView.animateWithDuration(0.5, animations: {
                self.expertBottomView.center.y = self.view.bounds.height / 1.14
                
            })
            isUp = true
        } else {
            UIView.animateWithDuration(0.5, animations: {
                self.expertBottomView.center.y = self.view.bounds.height * 1.14
                
            })
            isUp = false
        }
    }
    @IBAction func onCaptureClicked(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, animations: {
            self.expertBottomView.center.y = self.view.bounds.height * 1.14
            
        })
        isUp = false
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func onLibraryClicked(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, animations: {
            self.expertBottomView.center.y = self.view.bounds.height * 1.14
            
        })
        isUp = false
        
        let vc = UIImagePickerController()
        vc.navigationBar.translucent = false
        vc.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        vc.navigationBar.tintColor = UIColor.whiteColor()
        vc.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.whiteColor()
        ]
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
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
            onSubmit = true
            //2. Add the text field. You can configure it however you need.
            alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                
            })
            
            //3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action) -> Void in
                let textField = alert.textFields![0] as UITextField
                print("Text field: \(textField.text)")
                
                self.firstNameField.enabled = true
                self.lastNameField.enabled = true
                self.mailPart1Field.enabled = true
                self.mailPart2Field.enabled = true
                self.phoneField.enabled = true
                self.emailField.enabled = true
                self.photoEditButton.hidden = false
                self.secureEditButton.image = nil
                self.secureEditButton.title = "Submit"
            }))
            
            // 4. Present the alert.
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            onSubmit = false
            firstNameField.enabled = false
            lastNameField.enabled = false
            mailPart1Field.enabled = false
            mailPart2Field.enabled = false
            phoneField.enabled = false
            emailField.enabled = false
            self.photoEditButton.hidden = true
            self.secureEditButton.title = ""
            self.secureEditButton.image = UIImage(named: "editbutton.png")
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
