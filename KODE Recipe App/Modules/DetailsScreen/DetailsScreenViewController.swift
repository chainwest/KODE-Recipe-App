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
    
    @IBOutlet weak var sliderContainerView: UIView!
    @IBOutlet weak var sliderScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
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
            self?.setupImageSlider(recipe: (self?.viewModel.recipeResponse)!)
            self?.setupLabels(recipe: (self?.viewModel.recipeResponse)!)
            self?.setupDifficulty(recipe: (self?.viewModel.recipeResponse)!)
        }
    }
    
    private func setupImageSlider(recipe: RecipeResponse) {
        sliderScrollView.isPagingEnabled = true
        sliderScrollView.showsHorizontalScrollIndicator = false
        pageControl.numberOfPages = recipe.recipe.images.count
        
        for image in 0..<recipe.recipe.images.count {
            let imageView = UIImageView()
            let imageURL = URL(string: recipe.recipe.images[image])
            let xPosition = self.sliderContainerView.frame.width * CGFloat(image)
            
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.sliderScrollView.frame.width, height: self.sliderScrollView.frame.height)
            imageView.kf.setImage(with: imageURL)
            imageView.contentMode = .scaleAspectFill
            
            sliderScrollView.delegate = self
            sliderScrollView.contentSize.width = sliderScrollView.frame.width * CGFloat(image + 1)
            sliderScrollView.addSubview(imageView)
        }
    }
    
    private func setupLabels(recipe: RecipeResponse) {
        titleLabel.text = recipe.recipe.name
        //dateLabel.text = String(recipe.recipe.lastUpdated)
        descriptionLabel.text = recipe.recipe.description
        instructionLabel.text = recipe.recipe.instructions
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

extension DetailsScreenViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPageNumber = sliderScrollView.contentOffset.x / sliderScrollView.frame.size.width
        pageControl.currentPage = Int(currentPageNumber)
    }
}
