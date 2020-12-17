//
//  DashBoardViewController.swift
//  NewsBoom
//
//  Created by Apple on 12/12/20.
//

import Foundation

class DashBoardViewController: UIViewController,SlidingContainerViewControllerDelegate {
    
    var revealController:SWRevealViewController? = nil
    var blogPosts: [ParentCategory]=[ParentCategory]()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetAllParentCategoryData();
    }
    
   public func SetUptabs(){
        var titleArray:[String] = [String]()
        var vcArray:[UIViewController]=[UIViewController]()
        titleArray.append("Home")
    vcArray.append(Constant.storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController)
        for blog in self.blogPosts {
            titleArray.append(blog.Title)
            vcArray.append(viewControllerWithColorAndTitle(UIColor.white, title: blog.Title))
        }
//        let vc1 = viewControllerWithColorAndTitle(UIColor.white, title: "First View Controller")
//        let vc2 = viewControllerWithColorAndTitle(UIColor.white, title: "Second View Controller")
//        let vc3 = viewControllerWithColorAndTitle(UIColor.white, title: "Third View Controller")
//        let vc4 = viewControllerWithColorAndTitle(UIColor.white, title: "Forth View Controller")

        let slidingContainerViewController = SlidingContainerViewController (
          parent: self,
          contentViewControllers: vcArray,
          titles: titleArray)

        slidingContainerViewController.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        view.addSubview(slidingContainerViewController.view)

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
        revealController?.revealToggle(UIButton.init())
    }
    
    func viewControllerWithColorAndTitle (_ color: UIColor, title: String) -> UIViewController {
      let vc = UIViewController ()
      vc.view.backgroundColor = color

      let label = UILabel (frame: vc.view.frame)
      label.textColor = UIColor.black
      label.textAlignment = .center
      label.font = UIFont (name: "HelveticaNeue-Light", size: 25)
      label.text = title

      label.sizeToFit()
      label.center = view.center

      vc.view.addSubview(label)

      return vc
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
