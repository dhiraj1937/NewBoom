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



extension UIViewController:UITextFieldDelegate,UITextViewDelegate {
    
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
        spinnerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        if #available(iOS 13.0, *) {
            let ai = UIActivityIndicatorView.init(style: .gray)
            ai.startAnimating()
            ai.center = spinnerView.center
            DispatchQueue.main.async {
                spinnerView.addSubview(ai)
                onView.addSubview(spinnerView)
            }
        } else {
            // Fallback on earlier versions
            let ai = UIActivityIndicatorView(style: .whiteLarge)
            ai.startAnimating()
            ai.center = spinnerView.center
            DispatchQueue.main.async {
                spinnerView.addSubview(ai)
                onView.addSubview(spinnerView)
            }
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
        
        banner!.show(bannerPosition:BannerPosition.bottom ,on: vc,
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
    
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
            let nextTag = textField.tag + 1
            if let nextResponder = textField.superview?.viewWithTag(nextTag) {
                nextResponder.becomeFirstResponder()
    
            } else {
                textField.resignFirstResponder()
            }
            return true;
        }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
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
        self.image = nil;//UIImage.init(named: "splash-logo")
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

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}


@IBDesignable class GradientView: UIView {
    @IBInspectable var topColor: UIColor = UIColor.white
    @IBInspectable var bottomColor: UIColor = UIColor.black
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
    }
}

extension NSMutableAttributedString {
    
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}

extension UINavigationController
{
    /// Given the kind of a (UIViewController subclass),
    /// removes any matching instances from self's
    /// viewControllers array.
    
    func removeAnyViewControllers(ofKind kind: AnyClass)
    {
        self.viewControllers = self.viewControllers.filter { !$0.isKind(of: kind)}
    }
    
    /// Given the kind of a (UIViewController subclass),
    /// returns true if self's viewControllers array contains at
    /// least one matching instance.
    
    func containsViewController(ofKind kind: AnyClass) -> Bool
    {
        return self.viewControllers.contains(where: { $0.isKind(of: kind) })
    }
    
    func  GetViewControllerFromStack(ofKind kind: AnyClass) -> UIViewController{
        var findVC:UIViewController = UIViewController.init()
        for vc in viewControllers {
            if vc.isKind(of:kind) {
                findVC = vc;
            }
        }
        return findVC;
    }
}

@IBDesignable class InsetLabel: UILabel {
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    var insets: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        }
        set {
            topInset = newValue.top
            leftInset = newValue.left
            bottomInset = newValue.bottom
            rightInset = newValue.right
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjSize = super.sizeThatFits(size)
        adjSize.width += leftInset + rightInset
        adjSize.height += topInset + bottomInset
        
        return adjSize
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += leftInset + rightInset
        contentSize.height += topInset + bottomInset
        
        return contentSize
    }
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "AvenirNext-Regular", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "AvenirNext-Regular", size: 15)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}

