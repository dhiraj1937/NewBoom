//
//  HomeViewController.swift
//  NewsBoom
//
//  Created by Apple on 16/12/20.
//

import Foundation
class HomeViewController: UIViewController{
    var listMostDiscussNews:[HomeNewsModel]?
    var listLatestNews:[HomeNewsModel]?
    var listMostReadNews:[HomeNewsModel]?
    var advertisement:AdvertiseModel?
    var listAllNews:[AllNewsModel] = [AllNewsModel]()
    
    @IBOutlet var tblNews:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetAdvData();
    }
}
