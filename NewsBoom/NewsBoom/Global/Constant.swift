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
    public static var languageType:Language = Language.English;
    
    public static var APIKey:String = "123456789123456789"
    private static var serverURL:String = "https://projects.seawindsolution.com/News/Newsboom/Webservices/"
    public static var getAllChildCategoryByParentCategoryUrl:String = Constant.serverURL+"getAllChildCategoryByParentCategory";
    public static var getAllParentCategoryDataUrl:String = Constant.serverURL+"getAllParentCategoryData";
    public static var getCategoryDataUrl:String = Constant.serverURL+"getCategoryData";
    public static var getRegionalDataUrl:String = Constant.serverURL+"getRegionalData";
    public static var getBreakingDataUrl:String = Constant.serverURL+"getBreakingData";
    public static var getLatestNewsDataUrl:String = Constant.serverURL+"getLatestNewsData";
    public static var getmostreadNewsDataUrl:String = Constant.serverURL+"getmostreadNewsData";
    public static var getNewsByCategoryIdUrl:String = Constant.serverURL+"getNewsByCategoryId";
    public static var newslatterUrl:String = Constant.serverURL+"newslatter";
    public static var getVideosByCategoryUrl:String = Constant.serverURL+"getVideosByCategory";
    public static var getVideoCategoryUrl:String = Constant.serverURL+"getVideoCategory";
    public static var getPhotographsUrl:String = Constant.serverURL+"getPhotographs";
    public static var getPhotoCategoryUrl:String = Constant.serverURL+"getPhotoCategory";
    public static var getPhotosByCategoryUrl:String = Constant.serverURL+"getPhotosByCategory";
    public static var setNewsViewsCountUrl:String = Constant.serverURL+"setNewsViewsCount";
    public static var getNewsSearchUrl:String = Constant.serverURL+"getNewsSearch";
    public static var getAdvUrl:String = Constant.serverURL+"getAdv";
    public static var getEpaperUrl:String = Constant.serverURL+"getEpaper";
    public static var SendOTPUrl:String = Constant.serverURL+"SendOTP";
    public static var customerRegistrationUrl:String = Constant.serverURL+"customerRegistration";
    
}

public enum Language {
    case English
    case Hindi
}
