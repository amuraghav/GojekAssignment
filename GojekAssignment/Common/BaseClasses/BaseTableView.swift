//
//  BaseTableView.swift
//  FlickerApp
//
//  Created by Pankaj Raghav on 26/09/20.
//  Copyright © 2020 Pankaj Raghav. All rights reserved.
//

import Foundation
import UIKit

class BaseTableView: UITableView {
    
    func registerCells(_ cells: UITableViewCell.Type...){
        cells.forEach { (cellName) in
            let identifier = String(describing: cellName.self)
            register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    func dequeueCell<T: UITableViewCell>(_ tableCell: T.Type) -> T {
        let cell = dequeueReusableCell(withIdentifier: String(describing: tableCell.self)) as! T
        return cell
    }
}
