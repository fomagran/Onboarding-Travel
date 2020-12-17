//
//  RestaurantCollectionViewCell.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/12/17.
//

import UIKit
import Lottie

class RestaurantCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var handleStartButtonTap:(()->Void)?
    
    func configure(item:RestaurantItem) {
        titleLabel.text = item.title
        startButton.backgroundColor = item.buttonColor
        startButton.setTitle(item.buttonTitle, for: .normal)
        let animation = Animation.named(item.animationName)
        animationView.animation = animation
        animationView.loopMode = .loop
        
        if !animationView.isAnimationPlaying {
            animationView.play()
        }
        
    }
    
    @IBAction func handleStartButton(_ sender: Any) {
        handleStartButtonTap?()
    }
}
