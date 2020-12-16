//
//  FashionViewController.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/12/08.
//

import UIKit

class FashionViewController: UIViewController {
    
    //MARK:Properties
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    private var items:[OnboardingItem] = []
    private var imageViews = [UIImageView]()
    var collectionViewWidth:CGFloat {
        return collection.frame.size.width
    }
    //MARK:LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpItems()
        setUpPageControl()
        setUpImageView()
    }
    
    //MARK:Helpers
    
    //이미지뷰 넣기
    private func setUpImageView() {
        items.forEach { item in
            let imageView = UIImageView(image: item.bgImage)
            imageView.contentMode = .scaleAspectFill
            imageView.alpha = 0.0
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            containerView.addSubview(imageView)
            NSLayoutConstraint.activate([imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
                                         imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)])
            imageViews.append(imageView)
            imageViews.first?.alpha = 1
        }
        //??뭐지 컬렉션뷰 앞에다가 넣는다는 뜻인가? - new
        containerView.bringSubviewToFront(collection)
    }
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
        let shouldHide = index == items.count - 1
        nextBtn.isHidden = shouldHide
    }
    
    //현재 인덱스 알아내기 -> new
    private func getCurrentIndex() -> Int {
        return Int(collection.contentOffset.x/collection.frame.width)
    }
    
    //MARK: ScrollView Functions
    
    //컬렉션뷰 스크롤 했을 때도 넥스트버튼 누른 것처럼 똑같이 하기
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = getCurrentIndex()
        showItem(at: index)
    }
    
    //페이드인 페이드 아웃 코드로 넣어주기
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let index = getCurrentIndex()
        let fadeInAlpha = (x - collectionViewWidth * CGFloat(index)) / collectionViewWidth
        let fadeOutAlpha = CGFloat(1-fadeInAlpha)
        let canShow = index < items.count - 1
        guard canShow else {return}
        imageViews[index].alpha = fadeOutAlpha
        imageViews[index + 1].alpha = fadeInAlpha
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
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "FashionCollectionViewCell", for: indexPath) as! FashionCollectionViewCell
        let item = items[indexPath.item]
        let shouldShow = indexPath.item == items.count - 1
        cell.showExploreButton(shouldShow: shouldShow)
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
