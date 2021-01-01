//
//  MenuViewController.swift
//  NewsBoom
//
//  Created by Apple on 12/12/20.
//

import Foundation
class MenuViewController: UIViewController {
    
    public  var menuList:[Menu] = [Menu]()
    @IBOutlet var tblMenu:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        SetMenu()
        // Do any additional setup after loading the view.
    }
    
    func SetMenu(){
        menuList.removeAll()
        menuList.append(Menu.init(name: "Home", icon: "Home"))
        menuList.append(Menu.init(name: "Photos", icon: "PhotosMenu"))
        menuList.append(Menu.init(name: "Videos", icon: "VideoMenu"))
        menuList.append(Menu.init(name: "Language", icon: "LanguageMenu"))
        menuList.append(Menu.init(name: "E-Paper", icon: "EbookMenu"))
        menuList.append(Menu.init(name: "News Letter", icon: "NewsMenu"))
        menuList.append(Menu.init(name: "About Us", icon: "AboutUsMenu"))
        menuList.append(Menu.init(name: "Contact Us", icon: "ContactUsMenu"))
        menuList.append(Menu.init(name: "Terms and Condition", icon: "TCMenu"))
        menuList.append(Menu.init(name: "Privacy Policy", icon: "PrivacyMenu"))
    }

}

extension MenuViewController : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        let menu = menuList[indexPath.row]
        cell.img.image = UIImage.init(named: menu.icon);
        cell.lblTitle.text = menu.name;
        if(indexPath.row == 0){
            cell.lblTitle.textColor = Constant.appColor;
            cell.contentView.backgroundColor = UIColor.init(hexString: "#DCDCDC");
        }
        else{
            cell.lblTitle.textColor = UIColor.darkGray;
            cell.contentView.backgroundColor = UIColor.white;
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 3){
            
            UIApplication.topViewController()?.navigationController?.popToViewController((UIApplication.topViewController()?.navigationController?.viewControllers[0])!, animated: true)
        }
        else if(indexPath.row == 1){
            var vc:PhotosCategoryViewController?=nil;
            if #available(iOS 13.0, *) {
                vc = Constant.storyboard.instantiateViewController(identifier: "PhotosCategoryViewController") as PhotosCategoryViewController
            } else {
                // Fallback on earlier versions
                vc = Constant.storyboard.instantiateViewController(withIdentifier: "PhotosCategoryViewController") as? PhotosCategoryViewController
            }
            Constant.GetCurrentVC().navigationController?.pushViewController(vc!, animated: true)
        }
        else if(indexPath.row == 2){
            var vc:VideosCategoryViewController?=nil;
            if #available(iOS 13.0, *) {
                vc = Constant.storyboard.instantiateViewController(identifier: "VideosCategoryViewController") as VideosCategoryViewController
            } else {
                // Fallback on earlier versions
                vc = Constant.storyboard.instantiateViewController(withIdentifier: "VideosCategoryViewController") as? VideosCategoryViewController
            }
            Constant.GetCurrentVC().navigationController?.pushViewController(vc!, animated: true)
        }
        else if(indexPath.row == 4){
            var vc:EBookViewController?=nil;
            if #available(iOS 13.0, *) {
                vc = Constant.storyboard.instantiateViewController(identifier: "EBookViewController") as EBookViewController
            } else {
                // Fallback on earlier versions
                vc = Constant.storyboard.instantiateViewController(withIdentifier: "EBookViewController") as? EBookViewController
            }
            Constant.GetCurrentVC().navigationController?.pushViewController(vc!, animated: true)
        }
        else if(indexPath.row == 5){
            var vc:ForgetPasswordPopupViewController?=nil;
            if #available(iOS 13.0, *) {
                vc = ForgetPasswordPopupViewController.init(nibName: "ForgetPasswordPopupViewController", bundle: nil)
            } else {
                // Fallback on earlier versions
                vc = ForgetPasswordPopupViewController.init(nibName: "ForgetPasswordPopupViewController", bundle: nil)
            }
            Constant.IsSubscribe = true;
            Constant.GetCurrentVC().present(vc!, animated: true, completion: nil)
        }
        else if(indexPath.row == 6){
            var vc:OtherInfoViewController?=nil;
            if #available(iOS 13.0, *) {
                vc = Constant.storyboard.instantiateViewController(identifier: "OtherInfoViewController") as OtherInfoViewController
            } else {
                // Fallback on earlier versions
                vc = Constant.storyboard.instantiateViewController(withIdentifier: "OtherInfoViewController") as? OtherInfoViewController
            }
            vc!.slug = "about-us";
            vc!.headerTitle = "About Us"
            Constant.GetCurrentVC().navigationController?.pushViewController(vc!, animated: true)
        }
        else if(indexPath.row == 7){
            var vc:OtherInfoViewController?=nil;
            if #available(iOS 13.0, *) {
                vc = Constant.storyboard.instantiateViewController(identifier: "OtherInfoViewController") as OtherInfoViewController
            } else {
                // Fallback on earlier versions
                vc = Constant.storyboard.instantiateViewController(withIdentifier: "OtherInfoViewController") as? OtherInfoViewController
            }
            vc!.slug = "contact-us";
            vc!.headerTitle = "Contact Us"
            Constant.GetCurrentVC().navigationController?.pushViewController(vc!, animated: true)
        }
        else if(indexPath.row == 8){
            var vc:OtherInfoViewController?=nil;
            if #available(iOS 13.0, *) {
                vc = Constant.storyboard.instantiateViewController(identifier: "OtherInfoViewController") as OtherInfoViewController
            } else {
                // Fallback on earlier versions
                vc = Constant.storyboard.instantiateViewController(withIdentifier: "OtherInfoViewController") as? OtherInfoViewController
            }
            vc!.slug = "term-and-condition";
            vc!.headerTitle = "Terms and Condition"
            Constant.GetCurrentVC().navigationController?.pushViewController(vc!, animated: true)
        }
        else if(indexPath.row == 9){
            var vc:OtherInfoViewController?=nil;
            if #available(iOS 13.0, *) {
                vc = Constant.storyboard.instantiateViewController(identifier: "OtherInfoViewController") as OtherInfoViewController
            } else {
                // Fallback on earlier versions
                vc = Constant.storyboard.instantiateViewController(withIdentifier: "OtherInfoViewController") as? OtherInfoViewController
            }
            vc!.slug = "privacy-policy";
            vc!.headerTitle = "Privacy Policy"
            Constant.GetCurrentVC().navigationController?.pushViewController(vc!, animated: true)
        }
        DashBoardViewController.revealController?.revealToggle(UIButton.init())
    }
}
