//
//  DetailCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-15.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell, Reusable {

    @IBOutlet weak var resourceImage: UIImageView!
    @IBOutlet weak var resourceDescription: UILabel!
    @IBOutlet weak var resourceTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var detailResource = Resources() {
        didSet {
            
            let url = URL(string: detailResource.photo)
            let data = try? Data(contentsOf: url!)
            let imageI: UIImage = UIImage(data: data!)!
            resourceImage.image = imageI
            
            let newDescription = detailResource.desc.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
            resourceDescription.text = newDescription
            
            resourceTitle.text = detailResource.title
            

        }
    }
}
