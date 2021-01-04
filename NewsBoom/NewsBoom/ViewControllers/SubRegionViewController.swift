//
//  SubRegionViewController.swift
//  NewsBoom
//
//  Created by Apple on 02/01/21.
//

import Foundation
class SubRegionViewController: UIViewController {
    @IBOutlet var tblRegion:UITableView!
    public var listRegion:[SubRegion] = [SubRegion]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblRegion.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let backImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)


    }
}
