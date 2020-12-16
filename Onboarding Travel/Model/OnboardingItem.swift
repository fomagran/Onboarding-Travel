//
//  OnboardingItem.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/12/07.
//

import Foundation
import UIKit

struct OnboardingItem {
    let title:String
    let detail:String
    let bgImage:UIImage?
    
    static let travelItems:[OnboardingItem] = [
        .init(title: "Travel Your Way", detail: "Travel the world by air,rail or sea at the most competitive prices", bgImage: #imageLiteral(resourceName: "imTravel1")),
            .init(title: "Stay Your Way", detail: "With over millions of hotels worldwide,find the perfect accomodation in the most amazing places!", bgImage: #imageLiteral(resourceName: "imTravel3")),
        .init(title: "Discover Your Way With New Features", detail: "Explore exotic destinations with our new features that link you to like-minded tavellers", bgImage: #imageLiteral(resourceName: "imTravel2")),
        .init(title: "Feast Your Way", detail: "We recommend you local cuisines that ar safe and highly recommended by the locals", bgImage: #imageLiteral(resourceName: "imTravel4"))
    ]
    
    static let fashionItems:[OnboardingItem] = [
        .init(title: "Alexander McQueen", detail: "I think there is beauty in everything. What 'normal' people perceive as ugly, I can usually see something of beauty in it.", bgImage: #imageLiteral(resourceName: "imFashion1")),
        .init(title: "Alexander Wang", detail: "Anyone can get dressed up and glamorous, but it is how people dress in their days off that are the most intriguing.", bgImage: #imageLiteral(resourceName: "imFashion4")),
        .init(title: "Diana Vreeland", detail: "You gotta have style. It helps you get down the stairs. It helps you get up in the morning. It’s a way of life. Without it, you’re nobody. I’m not talking about lots of clothes.", bgImage: #imageLiteral(resourceName: "imFashion2")),
        .init(title: "Hubert de Givenchy", detail: "The dress must follow the body of a woman, not the body following the shape of the dress.", bgImage: #imageLiteral(resourceName: "imFashion3"))
    ]
}
