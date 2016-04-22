//
//  availabilityCell.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 4/21/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit


class availabilityCell: UITableViewCell {

    
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    var frameAdded = false
    class var expandedHeight: CGFloat { get { return 160 } }
    class var defaultHeight: CGFloat { get { return 50 } }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func checkHeight(){
        startDatePicker.hidden = (frame.size.height < availabilityCell.expandedHeight)
        endDatePicker.hidden = (frame.size.height < availabilityCell.expandedHeight)
        
    }
    
    func watchFrameChanges(){
        if (!frameAdded){
            addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
            checkHeight()
            frameAdded = true
        }
    }
    func ignoreFrameChanges(){
        if(frameAdded){
            removeObserver(self, forKeyPath: "frame")
            frameAdded = false
        }
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    deinit {
        print("deinit called");
        ignoreFrameChanges()
    }

}
