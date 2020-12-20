//
//  Menu.swift
//  NewsBoom
//
//  Created by Apple on 12/12/20.
//

import Foundation
class Menu: NSObject {
    
    //MARK: Properties
    var name: String
    var icon: String
    
    init(name: String, icon: String) {
        self.icon = icon;
        self.name = name;
    }
}

public class ParentCategory:Decodable {
    var  Id:String;
    var Title:String;
    var EntDt:String
    var Status:String
    var child:String
    init(id: String, title: String,entDt: String, status: String,child: String) {
        self.Id = id
        self.Title = title
        self.EntDt = entDt
        self.Status = status
        self.child = child
    }
}

public class SocialRegisterModel:Codable {
    // SignBy,Firstname,Lastname,Email,SocialId
    var SignBy:String;
    var Firstname:String;
    var Lastname:String
    var Email:String
    var SocialId:String
    init(SignBy: String, Firstname: String,Lastname: String, Email: String,SocialId: String) {
        self.SignBy = SignBy
        self.Firstname = Firstname
        self.Lastname = Lastname
        self.Email = Email
        self.SocialId = SocialId
    }
}

public class RegisterModel:Codable {
    var SignBy:String;
    var Firstname:String;
    var Lastname:String
    var Email:String
    var Password:String
    init(SignBy: String, Firstname: String,Lastname: String, Email: String,Password: String) {
        self.SignBy = SignBy
        self.Firstname = Firstname
        self.Lastname = Lastname
        self.Email = Email
        self.Password = Password
    }
}

public class HomeNewsModel:Decodable {
    var  Id:String;
    var Title:String;
    var Slug:String
    var Content:String
    var YoutubeUrl:String
    var NewsViews:String
    var NewsShared:String
    var EntDt:String
    var EntBy:String
    var ModDt:String
    var Status:String
    var NewsImg:[String]?
    var NewsVideo:[String]?
    var NewsAudio:[String]?
    var ThumbImg:String?
    init(Id: String, Title: String,Slug: String, Content: String,YoutubeUrl:String,NewsViews:String,NewsShared:String,EntDt:String,EntBy:String,ModDt:String,Status:String,NewsImg:[String],NewsVideo:[String],NewsAudio:[String],ThumbImg:String) {
        self.Id = Id
        self.Title = Title
        self.Slug = Slug
        self.Content = Content
        self.YoutubeUrl = YoutubeUrl
        self.NewsViews = NewsViews
        self.NewsShared = NewsShared
        self.EntDt = EntDt
        self.EntBy = EntBy
        self.ModDt = ModDt
        self.Status = Status
        self.NewsImg = NewsImg
        self.NewsVideo = NewsVideo
        self.NewsAudio = NewsAudio
        self.ThumbImg = ThumbImg
    }
}

public class AdvertiseModel:Decodable{
    var  Id:String;
    var Title:String;
    var Link:String
    var Img:String
    init(Id: String, Title: String,Link: String, Img: String) {
        self.Id = Id
        self.Title = Title
        self.Link = Link
        self.Img = Img
    }
}

public class NewsModel:Decodable{
    var Id:String;
    var NewsType:String;
    var Title:String;
    var Views:String;
    var Link:String;
    var Img:String;
    var DateTime:String
    var homeNewsModel:HomeNewsModel
    init(Id: String, NewsType:String,Title:String, Views:String,Link:String,Img:String,DateTime:String,homeNewsModel:HomeNewsModel) {
        self.Id = Id
        self.Title = Title
        self.NewsType = NewsType
        self.Views = Views
        self.Link = Link
        self.Img = Img
        self.DateTime = DateTime
        self.homeNewsModel = homeNewsModel
    }
}

public class AllNewsModel:Decodable{
    var Newstype:String;
    var listModeDisNews:[NewsModel];
    var Advertise:AdvertiseModel?;
    var News:NewsModel?;
    init(Newstype:String,listModeDisNews:[NewsModel],Advertise:AdvertiseModel?,News:NewsModel?) {
        self.Advertise = Advertise;
        self.listModeDisNews = listModeDisNews;
        self.Newstype = Newstype;
        self.News = News;
    }
}

public class EPaperModel:Decodable{
    var  Id:String;
    var Title:String;
    var Epaper:String
    var EpaperDate:String
    init(Id: String, Title: String,Epaper: String, EpaperDate: String) {
        self.Id = Id
        self.Title = Title
        self.Epaper = Epaper
        self.EpaperDate = EpaperDate
    }
}
