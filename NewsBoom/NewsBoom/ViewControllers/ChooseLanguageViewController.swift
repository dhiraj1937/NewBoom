//
//  ChooseLanguageViewController.swift
//  NewsBoom
//
//  Created by Apple on 12/12/20.
//

import Foundation
class ChooseLanguageViewController: UIViewController {

    @IBOutlet var btnHindi:UIButton!
    @IBOutlet var btnEnglish:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar(backgroundColor: Constant.appColor)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnContinue(){
       
        let signupVC = Constant.storyboard.instantiateViewController(identifier:"LoginViewController") as LoginViewController
        self.navigationController?.pushViewController(signupVC, animated: true);
    }
    
    @IBAction func btnSelectLanguage(sender:UIButton){
        btnHindi.backgroundColor = UIColor.black
        btnEnglish.backgroundColor = UIColor.black
        sender.backgroundColor = Constant.appColor
        if(sender.tag==0){
            Constant.languageType = Language.Hindi
        }
        else{
            Constant.languageType = Language.English
        }
    }
}
