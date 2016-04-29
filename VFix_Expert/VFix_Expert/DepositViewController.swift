//
//  DepositViewController.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 4/25/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit

class DepositViewController: UIViewController {

    @IBOutlet weak var bankInfoView: UIView!
    @IBOutlet weak var cardholderName: UILabel!
    @IBOutlet weak var bankName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bankInfoView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        bankInfoView.layer.shadowOffset = CGSizeMake(2, 2);
        bankInfoView.layer.shadowOpacity = 0.5;
        bankInfoView.layer.shadowRadius = 1.0;
        bankInfoView.layer.masksToBounds = false
        bankInfoView.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func shouldAutorotate() -> Bool {
        return false
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
