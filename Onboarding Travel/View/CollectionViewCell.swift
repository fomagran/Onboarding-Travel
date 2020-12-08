//
//  CollectionViewCell.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/12/08.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    func configure(with item:OnboardingItem) {
        title.text = item.title
        detail.text = item.detail
    }
}
