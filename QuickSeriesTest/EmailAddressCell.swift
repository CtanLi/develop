//
//  EmailAddressCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-16.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class EmailAddressCell: UITableViewCell, Reusable {

    var emailFunction: (() -> (Void))!
    @IBOutlet weak var emailAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var emailResource = Resources() {
        didSet {
            
            emailAddress.text = emailResource.email
        }
    }
    
    
    @IBAction func emailAction(_ sender: Any) {
        emailFunction()
    }
    
    func setAction(_ function: @escaping () -> Void) {
        self.emailFunction = function
    }
}
