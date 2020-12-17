//
//  RestaurantCollectionViewController.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/12/17.
//

import UIKit

class RestaurantCollectionViewController: UICollectionViewController {
    
    //MARK:Properties
    
    //컬렉션뷰 컨트롤러로 만들어서 넣진 못하지만 만약 넣을거면 IBOutlet으로 넣어야함.
    var pageControl:UIPageControl!
    private let items = RestaurantItem.collection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollection()
    }
    
    private func setUpCollection() {
        //이거 해줘야 콜렉션뷰 플로우레이아웃이 제대로 구현됨.
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        //new - 뭔지모르겠음
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    private func handleActionButton(at indexpath:IndexPath) {
        if indexpath.item == items.count - 1{
            //MainAppViewController로 이동하기
            let mainAppViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController")
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate,
               let window = sceneDelegate.window {
                window.rootViewController = mainAppViewController
                UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
        }else{
            let nextItem = indexpath.item + 1
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            collectionView.scrollToItem(at: nextIndexPath, at: .top, animated: true)
            //이것도 넣어줘야 작동함.
//            pageControl.currentPage = nextItem
           
        }
    }
    
    //이것도 마찬가지로 넣진 못하지만 코드만 적어놓음. 페이지 컨트롤 세로로 하는방법
    private func setUpPageControl() {
        pageControl.numberOfPages = items.count
        let angle = CGFloat.pi/2
        pageControl.transform = CGAffineTransform(rotationAngle: angle)
    }
    //페이지 컨트롤 현재 인덱스 적용
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.y/scrollView.frame.size.height)
        pageControl.currentPage = index
    }

  

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell", for: indexPath) as! RestaurantCollectionViewCell
        let item = items[indexPath.item]
        cell.configure(item:item)
        cell.handleStartButtonTap = { [weak self] in
            self?.handleActionButton(at:indexPath)
        }
        return cell
    }

}
//MARK:UICollectionViewDelegateFlowLayout
extension RestaurantCollectionViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
  
    
}
