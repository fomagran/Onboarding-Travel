//
//  FashionViewController.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/12/08.
//

import UIKit

class FashionViewController: UIViewController {
    
    //MARK:Properties
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    private var items:[OnboardingItem] = []
    //MARK:LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpItems()
        
    }
    
    //MARK:Helpers
    
    private func setUpItems() {
        items = OnboardingItem.fashionItems
    }
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection.collectionViewLayout = layout
    }
    
    //MARK:Actions
    @IBAction func handleNextButton(_ sender: Any) {
        
    }
    
}

//MARK:UICollectionViewDelegate
extension FashionViewController:UICollectionViewDelegate {
    
}
//MARK:UICollectionViewDataSource
extension FashionViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        let item = items[indexPath.item]
        cell.configure(with: item)
        return cell
    }
    
    
}
//MARK:UICollectionViewDelegateFlowLayout
extension FashionViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collection.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
