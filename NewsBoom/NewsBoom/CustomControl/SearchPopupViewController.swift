//
//  SearchPopupViewController.swift
//  NewsBoom
//
//  Created by Apple on 21/12/20.
//

import UIKit

class SearchPopupViewController: UIViewController {
    @IBOutlet var txtSearch:UITextField!
    var navigation:UINavigationController!
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissView))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissView(){
            self.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func btnSearch(){
        if(txtSearch.text?.count==0){
            ShowAlertMessage(message: "Please put search text.", vc: self)
            return
        }
        self.dismiss(animated: true, completion: nil)
        let vc = Constant.storyboard.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.searchKey = txtSearch.text;
        navigation.pushViewController(vc, animated: true)
    }
    
}

extension SearchPopupViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
}
