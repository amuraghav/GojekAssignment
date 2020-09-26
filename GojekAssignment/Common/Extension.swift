//
//  Extension.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 26/09/20.
//

import Foundation
import UIKit

extension UIViewController{
    typealias alertClosure = (() -> Void)?
    static func load<T: UIViewController>()-> T{
        T(nibName: String(describing: T.self), bundle: nil)
    }
    
    
    func showHUD(_ show: Bool){
        if !show{
            hideHUD()
            return
        }
        let window: UIWindow? = appDelegate.window
        guard let unwrappedWindow = window else { return }
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .orange
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        unwrappedWindow.addSubview(activityIndicator)
        
    activityIndicator.anchorToTop(top: unwrappedWindow.topAnchor, left: unwrappedWindow.leftAnchor, bottom: unwrappedWindow.bottomAnchor, right: unwrappedWindow.rightAnchor)
        activityIndicator.startAnimating()
    }
    
    func hideHUD(){
        DispatchQueue.main.async {
            let window: UIWindow? = self.appDelegate.window
            guard let unwrappedWindow = window else { return }
            
            for view in unwrappedWindow.subviews{
                if view is UIActivityIndicatorView{
                    view.removeFromSuperview()
                }
            }
        }
       
    }
    
    
    func showAlertMesssage(message:String?, onCompletion: alertClosure){
           let title = "Oops"
           let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
           let okButton = UIAlertAction.init(title: "OK", style: .default) { (action) in
               onCompletion?()
           }
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
       }

}

extension NSObject{
    var appDelegate: AppDelegate{
        UIApplication.shared.delegate as! AppDelegate
    }
    
}

extension UIView{
    func anchorToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,right: NSLayoutXAxisAnchor? = nil) {
        
        anchorWithConstantsToTop(top: top, left:left, bottom:  bottom, right: right, topConstant:  0 , leftConstant:  0 , bottomConstant:  0 , rightConstant:  0 )
    }
    
    func anchorWithConstantsToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0 , leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0,rightConstant: CGFloat = 0){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        
        if let left = left{
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if let right = right{
            rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
        }
    }
}
