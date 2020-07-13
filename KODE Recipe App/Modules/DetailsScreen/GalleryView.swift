//
//  GalleryView.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 07.07.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class GalleryView: UIView, UIScrollViewDelegate {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
       super.awakeFromNib()
       commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("GalleryView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setupImageSlider(recipe: RecipeResponse) {
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        pageControl.numberOfPages = recipe.recipe.images.count
        
        for image in 0..<recipe.recipe.images.count {
            let imageView = UIImageView()
            let imageURL = URL(string: recipe.recipe.images[image])
            let xPosition = self.containerView.frame.width * CGFloat(image)
            
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            imageView.kf.setImage(with: imageURL)
            imageView.contentMode = .scaleAspectFill
            
            scrollView.delegate = self
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(image + 1)
            scrollView.addSubview(imageView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(currentPageNumber)
    }
    
}
