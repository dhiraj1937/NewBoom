//
//  ForgetPasswordPopupViewController.swift
//  NewsBoom
//
//  Created by Apple on 25/12/20.
//

import UIKit

class ForgetPasswordPopupViewController: UIViewController {

    @IBOutlet var txtEmail:UITextField!
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

}

extension ForgetPasswordPopupViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
}
