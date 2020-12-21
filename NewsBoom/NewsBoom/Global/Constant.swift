//
//  Constant.swift
//  NewsBoom
//
//  Created by Apple on 12/12/20.
//

import Foundation
class Constant{
    
    public static var storyboard = UIStoryboard(name: "Main", bundle: nil)
    public static var appColor:UIColor = UIColor.init(hexString: "#C00A00");
    public static var languageType:Language = Language.Hindi;
    public static var  globalAdvertisement:AdvertiseModel?
    
    public static var APIKey:String = "123456789123456789"
    private static var serverHindiURL:String = "https://projects.seawindsolution.com/News/Newsboom/Webservices/"
    private static var serverEnglishURL:String = "https://projects.seawindsolution.com/News/Newsboom/english/Webservices/"
    public static var getAllChildCategoryByParentCategoryUrl:String = Constant.GetServerURL()+"getAllChildCategoryByParentCategory";
    public static var getAllParentCategoryDataUrl:String = Constant.GetServerURL()+"getAllParentCategoryData";
    public static var getCategoryDataUrl:String = Constant.GetServerURL()+"getCategoryData";
    public static var getRegionalDataUrl:String = Constant.GetServerURL()+"getRegionalData";
    public static var getBreakingDataUrl:String = Constant.GetServerURL()+"getBreakingData";
    public static var getLatestNewsDataUrl:String = Constant.GetServerURL()+"getLatestNewsData";
    public static var getmostdiscussNewsDataUrl:String = Constant.GetServerURL()+"getmostdiscussNewsData";
    public static var getmostreadNewsDataUrl:String = Constant.GetServerURL()+"getmostreadNewsData";
    public static var getNewsByCategoryIdUrl:String = Constant.GetServerURL()+"getNewsByCategoryId";
    public static var newslatterUrl:String = Constant.GetServerURL()+"newslatter";
    public static var getVideosByCategoryUrl:String = Constant.GetServerURL()+"getVideosByCategory";
    public static var getVideoCategoryUrl:String = Constant.GetServerURL()+"getVideoCategory";
    public static var getPhotographsUrl:String = Constant.GetServerURL()+"getPhotographs";
    public static var getPhotoCategoryUrl:String = Constant.GetServerURL()+"getPhotoCategory";
    public static var getPhotosByCategoryUrl:String = Constant.GetServerURL()+"getPhotosByCategory";
    public static var setNewsViewsCountUrl:String = Constant.GetServerURL()+"setNewsViewsCount";
    public static var getNewsSearchUrl:String = Constant.GetServerURL()+"getNewsSearch";
    public static var getAdvUrl:String = Constant.GetServerURL()+"getAdv";
    public static var getEpaperUrl:String = Constant.GetServerURL()+"getEpaper";
    public static var SendOTPUrl:String = Constant.GetServerURL()+"SendOTP";
    public static var customerRegistrationUrl:String = Constant.GetServerURL()+"customerRegistration";
    public static var getPageUrl:String = Constant.GetServerURL()+"getPage";
    
    static func GetServerURL()->String{
        if(Constant.languageType == Language.Hindi){
            return Constant.serverHindiURL;
        }
        else{
            return Constant.serverEnglishURL
        }
    }
    
    static func GetCurrentVC()->UIViewController{
        guard let wd = UIApplication.shared.delegate?.window else {
            return UIViewController.init();
        }
        var vc = wd!.rootViewController
        if(vc is UINavigationController){
            vc = (vc as! UINavigationController).visibleViewController
        }
        return vc!;
    }
    
    static func setGradientBackground(view:UIView,topColor:UIColor,bottomColor:UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, bottomColor]
        //gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = CGRect.zero
        view.layer.addSublayer(gradientLayer)
    }
}

public enum Language {
    case English
    case Hindi
}
