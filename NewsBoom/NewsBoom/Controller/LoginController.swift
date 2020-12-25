//
//  LoginController.swift
//  NewsBoom
//
//  Created by Apple on 15/12/20.
//

import Foundation
import FacebookLogin
import FacebookCore
import GoogleSignIn
import NotificationBannerSwift
import SwiftyJSON

extension LoginViewController:GIDSignInDelegate{
    //MARK: Google SignIn Completion Handler
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        self.showSpinner(onView: self.view)
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let profileImageURL = user.profile.imageURL(withDimension: 100)
        let email = user.profile.email
        let socialModel = SocialRegisterModel(SignBy: "3", Firstname: fullName! , Lastname: fullName! , Email: email! , SocialId: userId!)
        FacebookRegistration(socialModel: socialModel)
        
    }
    
    
    @IBAction func LoginWithFaceBook(){
        do{
            let loginManager = LoginManager()
            loginManager.authType = .reauthorize
            loginManager.logOut()
            loginManager.logIn(
                permissions: [.publicProfile,.email],
                viewController: self
            ) { result in
                switch result {
                case .cancelled: break
                    
                case .failed( _): break
                    
                case .success( _, _, _):
                    self.showSpinner(onView: self.view);
                    if let accessToken = AccessToken.current?.tokenString {
                        self.fetchUserProfile(loginToken: accessToken)
                    }
                }
            }
        }
        catch _{
            //Helper.ShowAlertMessage(message: error.localizedDescription, vc: vc)
            //vc.removeSpinner(onView: vc.view)
        }
    }
    
    @IBAction func LoginWithGoogle(){
        do{
            GIDSignIn.sharedInstance()?.presentingViewController = self;
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance()?.signIn()
        }
        catch let error{
            //Helper.ShowAlertMessage(message: error.localizedDescription, vc: vc)
            //vc.removeSpinner(onView: vc.view)
        }
    }
    
    func FacebookRegistration(socialModel:SocialRegisterModel){
        
        ApiManager.sharedInstance.requestPOSTURL(Constant.customerRegistrationUrl, params:socialModel.dictionary , success: { (JSON) in
            self.removeSpinner(onView: self.view)
            let msg =  JSON["Message"].string
            if((JSON["IsSuccess"].bool) != false){
                //self.ShowAlertMessage(message:msg! , vc: self,title:"Success",bannerStyle: BannerStyle.success)
                self.NavigateToDashBoard()
            }
            else{
                self.ShowAlertMessage(message:msg! , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            
        }, failure:{ (Error) in
            self.ShowAlertMessage(message:Error.localizedDescription , vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
        })
        
    }
    
    func fetchUserProfile(loginToken:String)
    {
        
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480),location"],tokenString: loginToken,version: nil,httpMethod: HTTPMethod.get)
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error took place: \(error)")
                self.removeSpinner(onView: self.view)
                self.ShowAlertMessage(message: error!.localizedDescription, vc: self)
            }
            else
            {
                
                print("Print entire fetched result: \(JSON(result!))")
                var userInfo:[String:AnyObject] = [String:AnyObject]()
                let pictureData = JSON(result!).dictionaryObject!["picture"] as! NSDictionary
                let data = JSON(pictureData).dictionaryObject!["data"] as! NSDictionary
                let pictureUrlString  = data["url"] as! String
                let pictureUrl = NSURL(string: pictureUrlString)
                let imageData:NSData = NSData(contentsOf: pictureUrl as! URL)!
                if(imageData != nil){
                    userInfo["ProfileImage"] = imageData
                }
                else{
                    
                    //userInfo["ProfileImage"] = Data.init() as AnyObject
                }
                userInfo["SocialId"] = JSON(result!).dictionaryObject!["id"] as AnyObject
                userInfo["Name"] = JSON(result!).dictionaryObject!["name"] as AnyObject
                userInfo["Email"] = JSON(result!).dictionaryObject!["email"] as AnyObject
                userInfo["Phone"] = "" as AnyObject
                userInfo["Address"] = JSON(result!).dictionaryObject!["location"] as AnyObject
                userInfo["OTP"] = "" as AnyObject?
                userInfo["Password"] = ""  as AnyObject?
                userInfo["SignBy"] = "2" as AnyObject?
                //userInfo["SocialId"] = "2" as AnyObject?
                let socialModel = SocialRegisterModel(SignBy: "2", Firstname: (userInfo["Name"] as! String) , Lastname: (userInfo["Name"] as! String) , Email: (userInfo["Email"] as! String) , SocialId: (userInfo["SocialId"] as! String))
                self.FacebookRegistration(socialModel: socialModel)
                
            }
            //vc.removeSpinner(onView: vc.view)
        })
    }
    
    @IBAction func btnLoginCLick(){
        if (txtEmail.text?.count==0) {
            ShowAlertMessage(message: "Please enter email", vc: self)
            return;
        }
        else if (txtPassword.text?.count==0) {
            ShowAlertMessage(message: "Please enter password", vc: self)
            return;
        }
        let loginModle = LoginModel(Email: txtEmail.text!, Password: txtPassword.text!)
        Login(LoginModel: loginModle)
    }
    
    func Login(LoginModel:LoginModel){
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestPOSTURL(Constant.userLoginUrl, params:LoginModel.dictionary , success: { (JSON) in
            self.removeSpinner(onView: self.view)
            let msg =  JSON["Message"].string
            if((JSON["IsSuccess"].bool) != false){
                
                self.ShowAlertMessage(message:msg! , vc: self,title:"Success",bannerStyle: BannerStyle.success)
                self.NavigateToDashBoard()
              
            }
            else{
                self.ShowAlertMessage(message:msg! , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            
        }, failure:{ (Error) in
            self.ShowAlertMessage(message:Error.localizedDescription , vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
        })
        
    }
    
    @IBAction func btnForgetPassword(){
        let vc = ForgetPasswordPopupViewController.init(nibName: "ForgetPasswordPopupViewController", bundle: nil)
        Constant.GetCurrentVC().present(vc, animated: true, completion: nil)
    }
    
    func NavigateToDashBoard(){
        
        let menuVC = Constant.storyboard.instantiateViewController(identifier:"MenuViewController") as MenuViewController
        let dashBoardVC = Constant.storyboard.instantiateViewController(identifier:"DashBoardViewController") as DashBoardViewController
        
        let frontNavigation = UINavigationController.init(rootViewController: dashBoardVC)
        let rearNavigation = UINavigationController.init(rootViewController: menuVC)

        let swvc:SWRevealViewController = SWRevealViewController.init(rearViewController: rearNavigation, frontViewController: frontNavigation)
        swvc.delegate = self;
        swvc.rearViewRevealWidth = self.view.frame.size.width-50
        self.navigationController?.pushViewController(swvc, animated: true);
        UserDefaults.standard.setValue("true", forKey: "IsLoggedIn")
        UserDefaults.standard.synchronize()
    }
}
