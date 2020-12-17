//
//  MostReadNewCollectionViewCell.swift
//  NewsBoom
//
//  Created by Apple on 17/12/20.
//

import UIKit

class MostReadNewCollectionViewCell: UICollectionViewCell {
    @IBOutlet var icon: UIImageView!
    @IBOutlet var lblTilte:UILabel!
    @IBOutlet var lblCount:UILabel!
    @IBOutlet var lbldate:UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
