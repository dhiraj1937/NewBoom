//
//  OtherInfoViewController.swift
//  NewsBoom
//
//  Created by Apple on 21/12/20.
//

import Foundation
class OtherInfoViewController: UIViewController {
    @IBOutlet var txtView:UITextView!
    @IBOutlet var lblTitle:UILabel!
    var slug:String?
    var headerTitle:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = headerTitle;
        self.GetOtherInfoData(slug: slug!)
    }
}
