//
//  MainScreenTableViewCell.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 27.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView! {
        didSet {
            recipeImageView.layer.masksToBounds = true
            recipeImageView.layer.cornerRadius = 10
        }
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func setupCell(viewModel: MainScreenViewModel, indexPath: IndexPath) {
        let imageURL = URL(string: (viewModel.recipeList[indexPath.row].images.first)!)
        let timeInterval = Double(viewModel.recipeList[indexPath.row].lastUpdated)
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        titleLabel.text = viewModel.recipeList[indexPath.row].name
        descriptionLabel.text = viewModel.recipeList[indexPath.row].description
        dateLabel.text = formatter.string(from: date)
        recipeImageView.kf.setImage(with: imageURL)
    }
}
