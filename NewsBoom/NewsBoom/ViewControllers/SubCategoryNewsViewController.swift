//
//  SubCategoryNewsViewController.swift
//  NewsBoom
//
//  Created by Apple on 20/12/20.
//

import Foundation
class SubCategoryNewsViewController: UIViewController{
    @IBOutlet var tblNews:UITableView!
    var pageCount:Int = 1;
    var totalRecord:Int = 0;
    var listNews:[HomeNewsModel] = [HomeNewsModel]()
    var isLoading:Bool = false;
    public var catID:String="0";
    var refreshControl = UIRefreshControl()
    public var headerTitle:String = ""
    override func viewDidLoad() {
        super.viewDidLoad();
        pageCount = 1
        refreshControl.addTarget(self, action: #selector(self.Refresh), for: .valueChanged)
        tblNews.addSubview(refreshControl)
        DispatchQueue.global(qos: .background).async { [self] in
            GetNewsByCategoryData(categoryID: catID, pageNo: pageCount.description)
            DispatchQueue.main.async {
                print("dispatched to main")
              
            }
        }
        self.title = headerTitle;
       
    }
    
    @objc func Refresh(){
        GetNewsByCategoryData(categoryID: catID, pageNo: pageCount.description)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
