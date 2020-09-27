//
//  RepoInfoTableViewCell.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 27/09/20.
//

import UIKit

class RepoInfoTableViewCell: BaseTableViewCell {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var forkLabel: UILabel!
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
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
   
    override func layoutSubviews() {
        super.layoutSubviews()
      
        stackView?.addBackground(.lightGray)
        userImageView.roundCornersRadius(cornerRadius: userImageView.bounds.height/2, borderColor: .lightGray, borderWidth: 1.0)
    }
  
    func setup(){
        guard let value = data as? Repository else { return }
        userImageView.downloaded(from: value.avatar ?? "")
        descriptionLabel.text = value.welcomeDescription
        nameLabel.text = value.name
        forkLabel.text = "\(value.forks ?? 0) Forks"
        starLabel.text = "\(value.stars ?? 0) Stars"
        
    }
    
    
}
