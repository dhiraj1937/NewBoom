//
//  AdvertiseTableViewCell.swift
//  NewsBoom
//
//  Created by Apple on 17/12/20.
//

import UIKit

class AdvertiseTableViewCell: UITableViewCell {

    @IBOutlet var icon: UIImageView!
    @IBOutlet var lblTilte:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
