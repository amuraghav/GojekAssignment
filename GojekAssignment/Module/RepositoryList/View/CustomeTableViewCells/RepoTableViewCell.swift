//
//  RepoTableViewCell.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 26/09/20.
//

import UIKit

class RepoTableViewCell: BaseTableViewCell {

    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    override var data: Any?{
        didSet{
            setup()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(){
        guard let value = data as? Repository else { return }
        descriptionLabel.text = value.description
        starLabel.text = "\(value.stars ?? 0)"
        nameLabel.text = value.name
    }
}
