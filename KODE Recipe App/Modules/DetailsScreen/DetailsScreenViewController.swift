//
//  DetailsScreenViewController.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 29.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsScreenViewController: UIViewController, UIScrollViewDelegate {
    let viewModel: DetailsScreenViewModel
    
    @IBOutlet weak var galleryView: GalleryView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var difficultyOne: UIImageView!
    @IBOutlet weak var difficultyTwo: UIImageView!
    @IBOutlet weak var difficultyThree: UIImageView!
    @IBOutlet weak var difficultyFour: UIImageView!
    @IBOutlet weak var difficultyFive: UIImageView!
    
    
    init(viewModel: DetailsScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getRecipe()
        bindToViewModel()
    }
    
    private func bindToViewModel() {
        viewModel.onDidUpdate = { [weak self] in
            self?.galleryView.setupImageSlider(recipe: (self?.viewModel.recipeResponse)!)
            self?.setupLabels(recipe: (self?.viewModel.recipeResponse)!)
            self?.setupDifficulty(recipe: (self?.viewModel.recipeResponse)!)
        }
    }
    
    private func setupLabels(recipe: RecipeResponse) {
        let timeInterval = Double(recipe.recipe.lastUpdated)
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        titleLabel.text = recipe.recipe.name
        dateLabel.text = formatter.string(from: date)
        descriptionLabel.text = recipe.recipe.description
        instructionLabel.text = recipe.recipe.instructions.replacingOccurrences(of: "<br>", with: "\n\n")
    }
    
    private func setupDifficulty(recipe: RecipeResponse) {
        var difficulty = recipe.recipe.difficulty
        let imageViews = [
           difficultyOne,
           difficultyTwo,
           difficultyThree,
           difficultyFour,
           difficultyFive
        ]
        
        for imageView in imageViews {
            if difficulty > 0 {
                imageView?.image = UIImage(named: "Shape")
                difficulty -= 1
            } else {
                imageView?.image = UIImage(named: "Shape-2")
            }
        }
    }
}
