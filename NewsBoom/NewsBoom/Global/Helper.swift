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
    @IBInspectable override var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
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

@IBDesignable extension UITextField {
    @IBInspectable var leftSpace:CGFloat {
        set {
            leftViewMode = ViewMode.always
            leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: newValue, height: frame.size.height))
        }
        get{
            return 20
            
        }
    }
    
    
    
    @IBInspectable var leftImage:UIImage {
        set {
            leftViewMode = ViewMode.always
            let imgView = UIImageView.init(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 45, height: 30))
            imgView.image = newValue
            view.addSubview(imgView)
            leftView = view
        }
        get{
            return UIImage.init()
            
        }
    }
    
    @IBInspectable var RightImage:UIImage {
        set {
            rightViewMode = ViewMode.always
            let imgView = UIImageView.init(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 45, height: 30))
            imgView.image = newValue
            view.addSubview(imgView)
            rightView = view
        }
        get{
            return UIImage.init()
            
        }
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
    
    @IBAction func btnBack_Click(){
        self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func btnLogout_Click(){
    self.navigationController?.popToRootViewController(animated: true);
    }
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
            
        } else {
            textField.resignFirstResponder()
        }
        return true;
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            textView.resignFirstResponder()
            return false;
        }
        else{
            return true;
        }
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

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

extension String {
    public init(deviceToken: Data) {
        self = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
    }
    var parseJSONString: AnyObject? {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        do{
            
            if let jsonData = data {
                return try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            } else {
                // Lossless conversion of the string was not possible
                return nil
            }
        }
        catch let error{
            
        }
         return nil
    }
    
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        URLSession.shared.dataTask(with: NSURL(string: encodedURL!)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()
    }}
extension UIView {
    
    /// The width of the layer's border, inset from the layer bounds. The border is composited above the layer's content and sublayers and includes the effects of the `cornerRadius' property. Defaults to zero. Animatable.
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    /// The color of the layer's border. Defaults to opaque black. Colors created from tiled patterns are supported. Animatable.
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    /// The color of the shadow. Defaults to opaque black. Colors created from patterns are currently NOT supported. Animatable.
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1] range will give undefined results. Animatable.
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    /// The shadow offset. Defaults to (0, -3). Animatable.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    /// The blur radius used to create the shadow. Defaults to 3. Animatable.
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat{
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
        
    }
}
