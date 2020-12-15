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

//public class Data:Decodable{
//    var height:Int
//    var is_silhouette:Bool
//    var width:Int
//    var url:String
//}
//
//public class Picture:Decodable{
//    var data:Data
//}
//
//public class FacebookUserInfo : Decodable{
//    var id:String;
//    var picture:Picture
//    var email:String
//    var name:String
//}


