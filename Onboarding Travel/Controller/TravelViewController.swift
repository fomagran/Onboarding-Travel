//
//  ViewController.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/11/30.
//

import UIKit

class TravelViewController: UIViewController {
    //MARK:Properties
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var DarkView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    private var currentPage:Int = 0
    
    private var items:[OnboardingItem] = []
    private let navigationManager = NavigationManager()
    private let onboardingCheckManager = OnboardingCheckManager()
    
    //MARK:LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpItems()
        setUpPageControl()
        setUpScreen(index: currentPage)
        updateBackgroundImage(index: currentPage)
        setUpGestures()
        setUpView()
        checkOnboardingSeen()
    }
    
    //MARK:Helpers
    
    private func checkOnboardingSeen() {
        onboardingCheckManager.setOnboardingSeen()
    }
    
    private func setUpItems() {
        items = OnboardingItem.travelItems
    }
    private func setUpPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func setUpScreen(index:Int) {
        titleLabel.text = items[index].title
        detailLabel.text = items[index].detail
        pageControl.currentPage = index
        titleLabel.alpha = 1.0
        detailLabel.alpha = 1.0
        titleLabel.transform = .identity
        detailLabel.transform = .identity
    }
    private func setUpGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tap)
    }
    
    private func updateBackgroundImage(index:Int) {
        let image = items[index].bgImage
        bgImageView.image = image
        UIView.transition(with: bgImageView, duration: 0.5, options: .transitionCrossDissolve,animations: {
            self.bgImageView.image = image
        },completion: nil)
    }
    
    private func setUpView() {
        DarkView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.5)
    }
    private func isOverLastItem() -> Bool {
        return currentPage == self.items.count
    }
    
    //MARK:Actions
    
    //옆으로 이동했다가 위로 사라지는 애니메이션
    @objc private func handleTapAnimation(){
        //타이틀레이블
  
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut,animations: {
            self.titleLabel.alpha = 0.8
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut,animations: {
                self.titleLabel.alpha = 0.0
                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            },completion: nil)
        }
        //디테일레이블
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut,animations: {
            self.detailLabel.alpha = 0.8
            self.detailLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { _ in
            if self.currentPage < self.items.count - 1 {
            self.updateBackgroundImage(index: self.currentPage + 1)
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut,animations: {
                self.detailLabel.alpha = 0.0
                self.detailLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            }) { _ in
                self.currentPage += 1
                if self.isOverLastItem() {
                    self.showMainApp()
                }else{
                    self.setUpScreen(index: self.currentPage)
                }
            }
        }

    }
    
    private func showMainApp() {
        navigationManager.show(screen: .mainApp, controller: self)
    }
    

}

