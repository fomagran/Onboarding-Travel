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
        setUpPageControl()
        
    }
    
    //MARK:Helpers
    
    private func setUpPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func setUpItems() {
        items = OnboardingItem.fashionItems
    }
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection.collectionViewLayout = layout
    }
    
    private func showItem(at index:Int) {
        pageControl.currentPage = index
    }
    
    //현재 인덱스 알아내기 -> new
    private func getCurrentIndex() -> Int {
        return Int(collection.contentOffset.x/collection.frame.width)
    }
    
    //MARK:Actions
    @IBAction func handleNextButton(_ sender: Any) {
        let nextRow = getCurrentIndex() + 1
        let nextIndexPath = IndexPath(row: nextRow, section: 0)
        //왼쪽으로 스크롤되게 하기 - new
        collection.scrollToItem(at: nextIndexPath, at: .left, animated: true)
        showItem(at: nextRow)
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
