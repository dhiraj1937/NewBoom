//
//  RegionalViewController.swift
//  NewsBoom
//
//  Created by Apple on 01/01/21.
//

import Foundation
class RegionalViewController: UIViewController {
    var listRegion:[Region] = [Region]()
    @IBOutlet var tblRegion:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.GetReginalData();
    }
}
