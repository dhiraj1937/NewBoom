//
//  PhotosCollectionViewCell.swift
//  NewsBoom
//
//  Created by Apple on 25/12/20.
//

import UIKit
import Foundation
class PhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imgBG:UIImageView!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblCount:UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    public func SetData(photModel:PhotosModel){
        lblTitle.text = photModel.Title;
        lblCount.text = photModel.Count.description;
        imgBG.imageFromServerURL(urlString: photModel.Photograph)
    }
    
    public func SetData(photSubModel:PhotosSubModel){
        lblTitle.text = photSubModel.ShortDescimg;
        imgBG.imageFromServerURL(urlString: photSubModel.Photo)
    }
    
    public func SetData(videoModel:VideosModel){
        lblTitle.text = videoModel.Title;
        imgBG.imageFromServerURL(urlString: videoModel.ThumbImg)
    }
    public func SetData(videoModel:VideoSubModel){
        lblTitle.text = videoModel.Title;
        let token =  (videoModel.Video as NSString).lastPathComponent;
        let editedURL = "http://img.youtube.com/vi/\(token)/1.jpg"
        imgBG.imageFromServerURL(urlString: editedURL)
    }
}
