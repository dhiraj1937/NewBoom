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
        menuList.append(Menu.init(name: "E Book", icon: "EbookMenu"))
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
        if(indexPath.row==0){
            cell.lblTitle.textColor = Constant.appColor;
            cell.contentView.backgroundColor = UIColor.init(hexString: "#DCDCDC");
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 3){
            
            UIApplication.topViewController()?.navigationController?.popToViewController((UIApplication.topViewController()?.navigationController?.viewControllers[0])!, animated: true)
        }
        else if(indexPath.row == 4){
            let vc = Constant.storyboard.instantiateViewController(identifier: "EBookViewController") as EBookViewController
            Constant.GetCurrentVC().navigationController?.pushViewController(vc, animated: true)
        }
    }
}
