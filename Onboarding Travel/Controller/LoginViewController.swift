//
//  LoginViewController.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/12/17.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var isOnboardingSeen :Bool!
    
    private let navigationManager = NavigationManager()
    private let onboardingCheckManager = OnboardingCheckManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        isOnboardingSeen = onboardingCheckManager.alreadyOnboardingSeen()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInitialScreen()
    }
    
    private func showInitialScreen() {
        if !isOnboardingSeen {
            navigationManager.show(screen: .onboarding, controller: self)
        }else{
            navigationManager.show(screen: .mainApp, controller: self)
        }
      
    }

}
    

