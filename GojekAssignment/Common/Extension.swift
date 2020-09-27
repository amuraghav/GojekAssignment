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
    
    func roundCornersRadius(cornerRadius: CGFloat , borderColor : UIColor? = .clear , borderWidth : CGFloat? = 1.0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth!
            self.clipsToBounds = true
            
        }
}

// MARK:- Download Image 

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIStackView {
    ///Adds a background view to the stackview with the desired color and applies some corner radius
    func addBackground(_ color: UIColor, cornerRadius: CGFloat = 5.0) {
        let backgroundView = UIView(frame: bounds)
//        backgroundView.backgroundColor = color
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.layer.cornerRadius = cornerRadius
        backgroundView.layer.borderColor = color.cgColor
        backgroundView.layer.borderWidth = 1.0
        self.clipsToBounds = true
        insertSubview(backgroundView, at: 0)
        
    }
}
