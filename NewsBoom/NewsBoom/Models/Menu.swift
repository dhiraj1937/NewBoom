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
