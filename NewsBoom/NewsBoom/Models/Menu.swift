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


