//
//  OnboardingCheckService.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/12/17.
//

import UIKit

class NavigationManager {
    enum Screen {
        case onboarding
        case mainApp
    }
    
    func show(screen:Screen,controller:UIViewController) {
        var viewController:UIViewController!
        switch screen {
        case .onboarding:
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TravelViewController")
        case .mainApp:
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController")
        }
        if let sceneDelegate = controller.view.window?.windowScene?.delegate as? SceneDelegate,let window = sceneDelegate.window {
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}

class OnboardingCheckManager {
    enum Key:String {
    case onboardingSeen
}
    func alreadyOnboardingSeen() -> Bool {
        UserDefaults.standard.bool(forKey: Key.onboardingSeen.rawValue)
    }
    func setOnboardingSeen() {
        UserDefaults.standard.set(true,forKey: Key.onboardingSeen.rawValue)
    }
    func resetOnboardingSeen() {
        UserDefaults.standard.set(false,forKey: Key.onboardingSeen.rawValue)
    }
}
