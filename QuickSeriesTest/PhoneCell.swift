//
//  PhoneCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-16.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class PhoneCell: UITableViewCell, Reusable {

    var phoneNum = ""
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var phoneResource = Resources() {
        didSet {
            phoneNum = String(phoneResource.phoneNumber)
            phoneNumber.text = phoneNum
        }
    }
    @IBAction func callAction(_ sender: Any) {
         makeCall()
    }
    
    func makeCall() {
        let number = URL(string: "tel://\(phoneNum)")
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number!)
        } else {
            // Fallback on earlier versions
        }
    }
}
