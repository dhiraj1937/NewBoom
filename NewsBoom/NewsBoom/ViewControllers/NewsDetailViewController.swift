//
//  NewsDetailViewController.swift
//  NewsBoom
//
//  Created by Apple on 20/12/20.
//

import Foundation
class NewsDetailViewController: UIViewController{
    
    @IBOutlet var lbltitle:UILabel!
    @IBOutlet var lblPublishBy:UILabel!
    @IBOutlet var lblDate:UILabel!
    @IBOutlet var lblViews:UILabel!
    @IBOutlet var img:UIImageView!
    @IBOutlet var txtView:UITextView!
    @IBOutlet var lblAdv:UILabel!
    @IBOutlet var imgAdv:UIImageView!
    public var newsHomeModel:HomeNewsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if(Constant.globalAdvertisement != nil){
            lblAdv.text = Constant.globalAdvertisement?.Title;
            imgAdv.imageFromServerURL(urlString: Constant.globalAdvertisement!.Img)
        }
        let text = "PUBLISHED BY:"+newsHomeModel.EntBy
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributedString.setColor(color: Constant.appColor, forText: "PUBLISHED BY:")
        lblPublishBy.attributedText = attributedString;
        lbltitle.text = newsHomeModel.Title;
        lblDate.text = newsHomeModel.EntBy;
        lblViews.text = newsHomeModel.NewsViews;
        img.imageFromServerURL(urlString: newsHomeModel.ThumbImg!)
        txtView.attributedText = newsHomeModel.Content.htmlToAttributedString;
    }
    
    @IBAction func btnShare(){
        let items: [Any] = [newsHomeModel.Title, URL(string: newsHomeModel.ThumbImg!)]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @IBAction func btnOpenAdvertiseMent(){
        if let url = URL(string: Constant.globalAdvertisement!.Link) {
            UIApplication.shared.open(url)
        }
    }
    
}
