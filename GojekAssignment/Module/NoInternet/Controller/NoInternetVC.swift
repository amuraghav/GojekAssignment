//
//  NoInternetVC.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 26/09/20.
//

import UIKit

class NoInternetVC: UIViewController {
    @IBOutlet var retryButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Github Trends"
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        retryButton.roundCornersRadius(cornerRadius: 5.0, borderColor: #colorLiteral(red: 0.431372549, green: 0.8235294118, blue: 0.4666666667, alpha: 1), borderWidth: 1)
    }
    @IBAction func retryBtnAction(sender : Any){
        
        self.dismiss(animated: true, completion: nil)
    }
}
extension NoInternetVC{
    static func instance() -> NoInternetVC{
        let controller: NoInternetVC = UIViewController.load()
        return controller
    }
}
