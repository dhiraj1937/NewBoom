//
//  DashBoardViewController.swift
//  NewsBoom
//
//  Created by Apple on 12/12/20.
//

import Foundation

class DashBoardViewController: UIViewController {
    var revealController:SWRevealViewController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        revealController = self.revealViewController()
        revealController!.panGestureRecognizer()
        revealController!.tapGestureRecognizer()
        
        let barButton = UIBarButtonItem.init(image: UIImage.init(named: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(DashBoardViewController.openCloseMenu))
        barButton.tintColor = Constant.appColor;
        self.navigationItem.leftBarButtonItem = barButton;
        
        let rightBarButton = UIBarButtonItem.init(image: UIImage.init(named: "search"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(DashBoardViewController.openCloseMenu))
        rightBarButton.tintColor = Constant.appColor;
      
        let menuBarButton = UIBarButtonItem.init(image: UIImage.init(named: "dotMenu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(DashBoardViewController.openCloseMenu))
        menuBarButton.tintColor = Constant.appColor;
        
        self.navigationItem.leftBarButtonItem = barButton;
        self.navigationItem.rightBarButtonItems = [menuBarButton,rightBarButton];
        
        let logo = UIImage(named: "navigationLogo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView

    }
    
    @objc func openCloseMenu(){
        revealController?.revealToggle(UIButton.init())
    }
}
