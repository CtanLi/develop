//
//  AddressCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-16.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell, Reusable {

    var addressFunction: (() -> (Void))!
    
     //Outlets
    @IBOutlet weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var addressResource = Resources() {
        didSet {
            address.text =  ("\(addressResource.address1) \( addressResource.state)\n \(addressResource.city ) \( addressResource.country) \( addressResource.zipCode)")
        }
    }
    
    @IBAction func addressAction(_ sender: Any) {
        addressFunction()
    }
    
    func setAction(_ function: @escaping () -> Void) {
        self.addressFunction = function
    }
}
