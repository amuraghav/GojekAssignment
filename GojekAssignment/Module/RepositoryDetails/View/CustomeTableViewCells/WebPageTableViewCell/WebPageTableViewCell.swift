//
//  WebPageTableViewCell.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 27/09/20.
//

import UIKit
import WebKit
class WebPageTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        addWebView()
    }
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

  
    
}

extension WebPageTableViewCell{
    func addWebView(){
        addSubview(webView)
        webView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 20, leftConstant: 18, bottomConstant: 16, rightConstant: 18)
        webView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 9 / 16, constant: 300).isActive = true
    }
}
