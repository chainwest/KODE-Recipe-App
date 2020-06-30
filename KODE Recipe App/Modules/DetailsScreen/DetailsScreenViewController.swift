//
//  DetailsScreenViewController.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 29.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsScreenViewController: UIViewController {
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
        bindToViewModel()
    }
    
    func bindToViewModel() {
        viewModel.getRecipe()
        viewModel.onDidUpdate = { [weak self] in
            self?.setupImageSlider(recipe: self!.viewModel.recipeResponse!)
        }
    }
    
    func setupImageSlider(recipe: Recipe) {
        sliderScrollView.frame = sliderContainerView.frame
        
        for i in 0..<recipe.images.count {
            let imageView = UIImageView()
            let image = URL(string: recipe.images[i])
            let xPosition = self.sliderContainerView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.sliderScrollView.frame.width, height: self.sliderScrollView.frame.height)
            imageView.kf.setImage(with: image)
            imageView.contentMode = .scaleAspectFit
            sliderScrollView.contentSize.width = sliderScrollView.frame.width * CGFloat(i + 1)
            sliderScrollView.addSubview(imageView)
        }
    }

}
