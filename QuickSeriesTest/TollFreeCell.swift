//
//  TollFreeCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-16.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class TollFreeCell: UITableViewCell, Reusable {

    var tollFreeNum = ""
    
    @IBOutlet weak var tollFree: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var tollFreeResource = Resources() {
        didSet {
            tollFreeNum = String(tollFreeResource.tollFree)
            tollFree.text = tollFreeNum
        }
    }
    
    @IBAction func callAction(_ sender: Any) {
        makeCall()
    }
    
    func makeCall() {
        let number = URL(string: "tel://\(tollFreeNum)")
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number!)
        } else {
            // Fallback on earlier versions
        }
    }
}
