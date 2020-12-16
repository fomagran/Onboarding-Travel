//
//  CollectionViewCell.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/12/08.
//

import UIKit

protocol FashionCollectionViewCellDelegate:class {
    func didTapExploreButton()
}

class FashionCollectionViewCell: UICollectionViewCell {
    weak var delegate:FashionCollectionViewCellDelegate?
    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    func configure(with item:OnboardingItem) {
        title.text = item.title
        detail.text = item.detail
    }
    
    func showExploreButton(shouldShow:Bool) {
        exploreButton.isHidden = !shouldShow
    }
    @IBAction func handleExploreButton(_ sender: Any) {
        delegate?.didTapExploreButton()
    }
}
