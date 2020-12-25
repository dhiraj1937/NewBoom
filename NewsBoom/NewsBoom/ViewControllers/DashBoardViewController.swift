//
//  DashBoardViewController.swift
//  NewsBoom
//
//  Created by Apple on 12/12/20.
//

import Foundation

class DashBoardViewController: UIViewController,SlidingContainerViewControllerDelegate {
    
    public static var revealController:SWRevealViewController? = nil
    var blogPosts: [ParentCategory]=[ParentCategory]()
    @IBOutlet var viewBG:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DashBoardViewController.revealController = self.revealViewController()
        DashBoardViewController.revealController!.panGestureRecognizer()
        DashBoardViewController.revealController!.tapGestureRecognizer()
        
        let barButton = UIBarButtonItem.init(image: UIImage.init(named: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(DashBoardViewController.openCloseMenu))
        barButton.tintColor = Constant.appColor;
        self.navigationItem.leftBarButtonItem = barButton;
        
        let rightBarButton = UIBarButtonItem.init(image: UIImage.init(named: "search"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(DashBoardViewController.ShowSearch))
        rightBarButton.tintColor = Constant.appColor;
        
        let menuBarButton = UIBarButtonItem.init(image: UIImage.init(named: "dotMenu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(DashBoardViewController.ShowHeaderMenu))
        menuBarButton.tintColor = Constant.appColor;
        
        self.navigationItem.leftBarButtonItem = barButton;
        self.navigationItem.rightBarButtonItems = [menuBarButton,rightBarButton];
        
        let logo = UIImage(named: "navigationLogo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        GetAllParentCategoryData();
    }
    
    @objc func ShowSearch(){
        let vc = SearchPopupViewController.init(nibName: "SearchPopupViewController", bundle: nil)
        vc.navigation = self.navigationController;
        Constant.GetCurrentVC().present(vc, animated: true, completion: nil)
    }
    
    @objc func ShowHeaderMenu(){
        
        let TitleString = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : Constant.appColor])
        let MessageString = NSAttributedString(string: "Action", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : Constant.appColor])

        
        let alert = UIAlertController(title: "", message: "Action", preferredStyle: .actionSheet)
        alert.setValue(TitleString, forKey: "attributedTitle")
        alert.setValue(MessageString, forKey: "attributedMessage")
        if((UserDefaults.standard.string(forKey: "IsLoggedIn")) != nil){
            alert.addAction(UIAlertAction(title: "Logout", style: .default , handler:{ (UIAlertAction)in
                if(self.navigationController?.containsViewController(ofKind: LoginViewController.self)==false){
                    let loginVC = Constant.storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.navigationController?.pushViewController(loginVC, animated: true)
                }
                else{
                    let loginVC = self.navigationController?.GetViewControllerFromStack(ofKind: LoginViewController.self);
                    self.navigationController?.popToViewController(loginVC!, animated: true);
                }
                UserDefaults.standard.removeObject(forKey: "IsLoggedIn");
                UserDefaults.standard.synchronize()
            }))
        }
        else{
            alert.addAction(UIAlertAction(title: "Login", style: .default , handler:{ (UIAlertAction)in
                UIApplication.topViewController()?.navigationController?.popToViewController((UIApplication.topViewController()?.navigationController?.viewControllers[1])!, animated: true)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        alert.view.tintColor = Constant.appColor;
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true);
    }
    
    public func SetUptabs(){
        var titleArray:[String] = [String]()
        var vcArray:[UIViewController]=[UIViewController]()
        titleArray.append("Home")
        vcArray.append(Constant.storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController)
        for blog in self.blogPosts {
            titleArray.append(blog.Title)
            let subCategoryVC = Constant.storyboard.instantiateViewController(withIdentifier: "SubCategoryNewsViewController") as! SubCategoryNewsViewController
            subCategoryVC.catID = blog.Id.description
            vcArray.append(subCategoryVC)
        }
        
        let slidingContainerViewController = SlidingContainerViewController (
            parent: self,
            contentViewControllers: vcArray,
            titles: titleArray)
        
        slidingContainerViewController.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(slidingContainerViewController.view)
        
        slidingContainerViewController.sliderView.appearance.outerPadding = 0
        slidingContainerViewController.sliderView.appearance.innerPadding = 30
        slidingContainerViewController.sliderView.appearance.fixedWidth = false
        slidingContainerViewController.setCurrentViewControllerAtIndex(0)
        slidingContainerViewController.sliderView.appearance.backgroundColor = UIColor.white
        slidingContainerViewController.sliderView.layer.shadowColor = UIColor.lightGray.cgColor
        slidingContainerViewController.sliderView.layer.shadowRadius=4;
        slidingContainerViewController.sliderView.layer.shadowOpacity=1
        slidingContainerViewController.sliderView.layer.shadowOffset=CGSize(width: 0 , height:2)
        slidingContainerViewController.sliderView.appearance.selectorColor = Constant.appColor
        slidingContainerViewController.sliderView.appearance.selectedTextColor = Constant.appColor
        slidingContainerViewController.delegate = self
    }
    
    @objc func openCloseMenu(){
        DashBoardViewController.revealController?.revealToggle(UIButton.init())
    }
   
}

extension DashBoardViewController
{
    // MARK: SlidingContainerViewControllerDelegate
    func slidingContainerViewControllerDidMoveToViewController(_ slidingContainerViewController: SlidingContainerViewController, viewController: UIViewController, atIndex: Int) {
        
    }
    
    func slidingContainerViewControllerDidShowSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidHideSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
}
