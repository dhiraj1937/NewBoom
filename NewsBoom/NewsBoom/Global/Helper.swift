//
//  Helper.swift
//  NewsBoom
//
//  Created by Apple on 12/12/20.
//

import Foundation
import UIKit
import SCLAlertView
import NotificationBannerSwift
class RoundedCornerView: UIView {

    // if cornerRadius variable is set/changed, change the corner radius of the UIView
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
public extension UIViewController {
    
    func setStatusBar(backgroundColor: UIColor) {
            let statusBarFrame: CGRect
            if #available(iOS 13.0, *) {
                statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
            } else {
                statusBarFrame = UIApplication.shared.statusBarFrame
            }
            let statusBarView = UIView(frame: statusBarFrame)
            statusBarView.backgroundColor = backgroundColor
            view.addSubview(statusBarView)
        }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.tag = -100
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
    }
    
    func removeSpinner(onView : UIView) {
        DispatchQueue.main.async {
            let v = onView.viewWithTag(-100)
            if(v != nil){
                v?.removeFromSuperview()
            }
        }
    }
    
    func ShowAlertMessage(message:String,buttonTitle:String = "OK",vc:UIViewController,title:String="",bannerStyle:BannerStyle = BannerStyle.success){
        var banner:FloatGrowingNotificationBanner?
        if(banner != nil){
            banner?.dismiss()
        }
        banner = FloatGrowingNotificationBanner(title: title, subtitle: message, style: bannerStyle,colors: CustomBannerColors())
        banner!.layer.cornerRadius = 5;
       
        banner!.show(on: vc,
        cornerRadius: 8,
        shadowColor: UIColor(red: 0.431, green: 0.459, blue: 0.494, alpha: 1),
        shadowBlurRadius: 16,
        shadowEdgeInsets: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
    }
    
    func ShowAlertMessageWithHandlesr(message:String,buttonTitle:String = "OK",title:String="",vc:UIViewController,action:@escaping () -> Void){
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "AvenirNext-Regular", size: 20)!,
            kTextFont: UIFont(name: "AvenirNext-Regular", size: 14)!,
            kButtonFont: UIFont(name: "AvenirNext-Medium", size: 14)!,
            showCloseButton: false,
            circleBackgroundColor: UIColor.init(hexString: "#FBAF40")
            )
        let alertView = SCLAlertView(appearance: appearance)
        //alertView.addButton("OK", backgroundColor: nil, textColor: nil, showTimeout: nil, action: action)
        //alertView.view.backgroundColor = UIColor.init(hexString: "#FBAF40")
        alertView.addButton("OK",backgroundColor:UIColor.init(hexString: "#FBAF40") ,action: action)
        alertView.showSuccess(title, subTitle: message)
  
    }
    
    func ShowAlertMessageWithHandlesr(message:String,buttonTitle:String = "OK",title:String="",vc:UIViewController,actionOK:@escaping () -> Void,actionCancel:@escaping () -> Void){
          
          let appearance = SCLAlertView.SCLAppearance(
              kTitleFont: UIFont(name: "AvenirNext-Regular", size: 20)!,
              kTextFont: UIFont(name: "AvenirNext-Regular", size: 14)!,
              kButtonFont: UIFont(name: "AvenirNext-Medium", size: 14)!,
              showCloseButton: false,
              circleBackgroundColor: UIColor.init(hexString: "#FBAF40")
              )
          let alertView = SCLAlertView(appearance: appearance)
          //alertView.addButton("OK", backgroundColor: nil, textColor: nil, showTimeout: nil, action: action)
          //alertView.view.backgroundColor = UIColor.init(hexString: "#FBAF40")
          alertView.addButton("OK",backgroundColor:UIColor.init(hexString: "#FBAF40") ,action: actionOK)
        alertView.addButton("Cancel",backgroundColor:UIColor.init(hexString: "#FBAF40") ,action: {() -> Void in
            alertView.dismiss(animated: true, completion: nil)
        })
          alertView.showSuccess(title, subTitle: message)
    
      }
    
    func ShowAlertWithTextViewWithHandlesr(message:String,buttonTitle:String = "OK",title:String="",vc:UIViewController,actionOK:@escaping () -> Void,actionCancel:@escaping () -> Void,result:@escaping (_ txt:String) -> Void,oldText:String){
          
          let appearance = SCLAlertView.SCLAppearance(
              kTitleFont: UIFont(name: "AvenirNext-Regular", size: 20)!,
              kTextFont: UIFont(name: "AvenirNext-Regular", size: 14)!,
              kButtonFont: UIFont(name: "AvenirNext-Medium", size: 14)!,
              showCloseButton: false,
              circleBackgroundColor: UIColor.init(hexString: "#FBAF40")
              )
          let alertView = SCLAlertView(appearance: appearance)
          let textView = alertView.addTextView()
          textView.text = oldText;
          alertView.addButton("OK",backgroundColor:UIColor.init(hexString: "#FBAF40") ,action: {() -> Void in
            result(textView.text)
            alertView.dismiss(animated: true, completion: nil)
        })
        alertView.addButton("Cancel",backgroundColor:UIColor.init(hexString: "#FBAF40") ,action: {() -> Void in
            actionCancel();
            alertView.dismiss(animated: true, completion: nil)
            
        })
        textView.becomeFirstResponder()
        alertView.showEdit(title, subTitle: message,circleIconImage: UIImage(named: "Pin"))
    
      }
    
    func ArchivedUserDefaultObject(obj:Any,key:String){
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: obj)
        UserDefaults.standard.set(encodedData, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func UnArchivedUserDefaultObject(key:String) -> Any {
        var decodedTeams:(Any)?;
        let decoded  = UserDefaults.standard.object(forKey: key) as? Data
        if(decoded != nil){
            decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded!)
            return decodedTeams;
        }
        return decodedTeams
    }
    
    func isObjectNotNil(object:AnyObject!) -> Bool
    {
        if object is NSNull
        {
            return true
        }
        
        return false
    }
}

class CustomBannerColors: BannerColorsProtocol {

    internal func color(for style: BannerStyle) -> UIColor {
        switch style {
        case .danger:
        return UIColor.init(hexString: "#cc3300")
        break    // Your custom .danger color
        case .info:
             return UIColor.init(hexString: "#99cc33")
            break        // Your custom .info color
        
        case .success:
            return UIColor.init(hexString: "#339900")
            break
        // Your custom .success color
        case .warning:
            return UIColor.init(hexString: "#ff9966")
            break    // Your custom .warning color
        case .none: break
            
        }
        
        return UIColor.green;
    }

}

