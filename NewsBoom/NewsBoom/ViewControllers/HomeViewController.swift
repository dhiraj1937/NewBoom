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
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad();
        refreshControl.addTarget(self, action: #selector(self.Refresh), for: .valueChanged)
        tblNews.addSubview(refreshControl)
        GetAdvData();
    }
    
    @objc func Refresh(){
        GetAdvData();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
}
