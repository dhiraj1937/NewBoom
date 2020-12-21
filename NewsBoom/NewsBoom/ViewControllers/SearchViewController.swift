//
//  SearchViewController.swift
//  NewsBoom
//
//  Created by Apple on 21/12/20.
//

import Foundation
class SearchViewController: UIViewController {
    @IBOutlet var tblNews:UITableView!
    var searchKey:String?
    var listNews:[HomeNewsModel] = [HomeNewsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        GetNewsBykeyData(serchKey: searchKey!)
    }
}
