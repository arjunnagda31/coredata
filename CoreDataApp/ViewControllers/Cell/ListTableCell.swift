//
//  ListTableCell.swift
//  CoreDataApp
//
//  Created by Mac on 7/4/18.
//  Copyright © 2018 Global Garner. All rights reserved.
//

import UIKit

class ListTableCell: UITableViewCell {

    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet var lblMobile: UILabel!
    @IBOutlet var lblDob: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgProfle: UIImageView!
    @IBOutlet var BackView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
