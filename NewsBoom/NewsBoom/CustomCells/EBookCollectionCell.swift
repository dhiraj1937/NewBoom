//
//  EBookCollectionCell.swift
//  NewsBoom
//
//  Created by Apple on 20/12/20.
//

import UIKit

class EBookCollectionCell: UICollectionViewCell {
    @IBOutlet var imgBG:UIImageView!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblDate:UILabel!
    @IBOutlet var viewBG:UIView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    public func SetData(epaperModel:EPaperModel){
        lblTitle.text = epaperModel.Title;
        lblDate.text = epaperModel.EpaperDate
        
    }
}
