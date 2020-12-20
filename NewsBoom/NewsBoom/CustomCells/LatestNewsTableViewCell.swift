//
//  LatestNewsTableViewCell.swift
//  NewsBoom
//
//  Created by Apple on 17/12/20.
//

import UIKit

class LatestNewsTableViewCell: UITableViewCell {

    @IBOutlet var icon: UIImageView!
    @IBOutlet var lblTilte:UILabel!
    @IBOutlet var lblCount:UILabel!
    @IBOutlet var lbldate:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func SetData(newsModel:AllNewsModel){
        icon.imageFromServerURL(urlString: newsModel.News!.Img)
        lblTilte.text = newsModel.News?.Title;
        lblCount.text = newsModel.News?.Views;
        lbldate.text = newsModel.News?.DateTime;
    }
    
    func SetData(homeNewsModel:HomeNewsModel){
        guard let imgArr = homeNewsModel.NewsImg else {
            return;
        }
        
        if(imgArr.count>0){
            icon.imageFromServerURL(urlString: homeNewsModel.NewsImg![0])
        }
        lblTilte.text = homeNewsModel.Title;
        lblCount.text = homeNewsModel.NewsViews;
        lbldate.text = homeNewsModel.EntDt;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
