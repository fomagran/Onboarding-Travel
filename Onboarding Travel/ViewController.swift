//
//  ViewController.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/11/30.
//

import UIKit

class ViewController: UIViewController {
    //MARK:Properties
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var DarkView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    private let items:[OnboardingItem] = [
        .init(title: "Travel Your Way", detail: "Travel the world by air,rail or sea at the most competitive prices", bgImage: nil),
            .init(title: "Stay Your Way", detail: "With over millions of hotels worldwide,find the perfect accomodation in the most amazing places!", bgImage: nil),
        .init(title: "Discover Your Way With New Features", detail: "Explore exotic destinations with our new features that link you to like-minded tavellers", bgImage: nil),
        .init(title: "Feast Your Way", detail: "We recommend you local cuisines that ar safe and highly recommended by the locals", bgImage: nil)
    ]
    private let currentPage:Int = 0
    
    //MARK:LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPageControl()
        setUpScreen(index: currentPage)
   
    }
    
    //MARK:Helpers
    private func setUpPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func setUpScreen(index:Int) {
        titleLabel.text = items[index].title
        detailLabel.text = items[index].detail
        pageControl.currentPage = index
    }
    private func setUpGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tap)
    }
    
    //MARK:Actions
    
    //옆으로 이동했다가 위로 사라지는 애니메이션
    @objc private func handleTapAnimation(){
        //타이틀레이블
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.titleLabel.alpha = 0.8
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                self.titleLabel.alpha = 0.0
                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -550)
                
            }
        }
        //디테일레이블
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.detailLabel.alpha = 0.8
            self.detailLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                self.detailLabel.alpha = 0.0
                self.detailLabel.transform = CGAffineTransform(translationX: 0, y: -550)
                
            }
        }

    }
    

}
