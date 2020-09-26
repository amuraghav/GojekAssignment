//
//  BaseViewModel.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 26/09/20.
//

import Foundation
class BaseViewModel{
    var showHUD: Bindable<Bool>                    = Bindable(false)
    var showAlert: Bindable<String?>               = Bindable(nil)
}
