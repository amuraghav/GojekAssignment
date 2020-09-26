//
//  RootController.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 26/09/20.
//

import Foundation
import UIKit
class RootControllers: NSObject{
    static let shared = RootControllers()
    @available(iOS 13.0, *)
    func setupWindow(_ scene: UIScene) -> UIWindow?{
        guard let windowScene = (scene as? UIWindowScene) else { return nil }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        return window
    }
    
func setupAppdelegateWindow() -> UIWindow{
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.makeKeyAndVisible()
    return window
}
    
}
