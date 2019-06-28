//
//  TabBarContainerViewController.swift
//  TabBar
//
//  Created by Mohamed Shaat on 5/25/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

public protocol TabBarDataSourse {
    func  configureTabCell( collectionView: UICollectionView, indexpath:IndexPath)  -> UICollectionViewCell
    func cellTabName() -> String
}

protocol TabBarDelegate {
    func move()
}
enum MoveType {
    case containerScrollMove
    case topBarScrollMove
    case topBarSelection
}

 open class TabBarContainerViewController: UIViewController {
    public var topBarView: UICollectionView!
    public var barcontainer: UIScrollView!
    var indictaorPage: UIView?
    public var selectedIndicatorColor = UIColor.blue
    public var tabBarShouldFillWidth = true
    public var tabBarWidth = 0.0
    var currentPage = 0
    var numberOfItemsAppearInOnePage = 0
    public var indicatorHeight: CGFloat = 1.0
    var moveType: MoveType = .containerScrollMove
    var minimumLineSpacing: CGFloat = 0.0
    var minimumInteritemSpacing: CGFloat = 0.0
    private var viewControllers: [UIViewController]  = [UIViewController]()
    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override open func viewDidLayoutSubviews() {
        reloadTabBar()
    }
    
    private func registerCell(cellIdentifier: String)  {
        topBarView.register(UINib(nibName: cellIdentifier, bundle: getBundle(cellIdentifier: cellIdentifier)), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func getBundle(cellIdentifier: String) -> Bundle {
        if cellIdentifier == TabBarCollectionViewCellTitle.resusableName || cellIdentifier == TabBarCollectionViewCellImage.resusableName || cellIdentifier == TabBarCollectionViewCellTitleWithImage.resusableName {
            return Bundle(for: TabBarContainerViewController.classForCoder())
        }
           return Bundle(for: NSObject.fromClassName(className:cellIdentifier)!)
    }
    
    public func setupTabBar(viewControllers : [UIViewController]) {
        self.viewControllers = viewControllers
        topBarView.dataSource = self
        topBarView.delegate = self
    }
    
    private func layoutCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        layout.scrollDirection = .horizontal
        topBarView.isPagingEnabled = true
        topBarView.showsHorizontalScrollIndicator = false
        if tabBarWidth == 0 || tabBarShouldFillWidth {
            numberOfItemsAppearInOnePage = viewControllers.count
            tabBarWidth = Double(topBarView.frame.size.width) / Double(viewControllers.count) - Double(minimumLineSpacing)
        } else {
            numberOfItemsAppearInOnePage = Int(Double(topBarView.frame.size.width) / (Double(tabBarWidth) + Double(minimumLineSpacing)))
        }
        layout.itemSize = CGSize(width: CGFloat(tabBarWidth), height: topBarView.frame.size.height)
        topBarView!.collectionViewLayout = layout
    }
    
    private func setupSlideScrollView() {
        barcontainer.delegate = self
        barcontainer.contentSize = CGSize(width: barcontainer.frame.width * CGFloat(viewControllers.count), height: barcontainer.frame.height)
        barcontainer.isPagingEnabled = true
        barcontainer.showsHorizontalScrollIndicator = false
        for i in 0 ..< viewControllers.count {
            viewControllers[i].view.frame = CGRect(x: barcontainer.frame.width * CGFloat(i), y: 0, width: barcontainer.frame.width, height: barcontainer.frame.height)
            if (UIView.appearance().semanticContentAttribute == .forceRightToLeft) {
                viewControllers[i].view.transform = CGAffineTransform(scaleX: -1,y: 1);
            }
            barcontainer.addSubview(viewControllers[i].view)
            self.addChildViewController(viewControllers[i])
        }
        
    }
    
    public func reloadTabBar() {
        setupSlideScrollView()
        layoutCells()
        setTabBarIndicator()
        self.moveTo(page: self.currentPage,animated: false)
        if (UIView.appearance().semanticContentAttribute == .forceRightToLeft) {
            self.barcontainer.transform = CGAffineTransform(scaleX: -1,y: 1);
            self.topBarView.semanticContentAttribute = .forceRightToLeft
        } else {
              self.topBarView.semanticContentAttribute = .forceLeftToRight
        }
        changeTopBarViewFrame()
    }
    
    func changeTopBarViewFrame(animated: Bool = true) {
        var topBarViewFrame: CGRect = self.topBarView.frame
        if let frame = getFrameForCurrentCell() {
         topBarViewFrame.origin.x = frame.origin.x - CGFloat(tabBarWidth)
        } else {
         topBarViewFrame.origin.x = 0.0
        }
        topBarViewFrame.size.width = CGFloat(tabBarWidth + Double(minimumLineSpacing)) * CGFloat((numberOfItemsAppearInOnePage))
        topBarViewFrame.origin.y = 0
        self.topBarView.scrollRectToVisible(topBarViewFrame, animated: true)
        self.moveTo(page: Int( self.currentPage))
        
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView != self.barcontainer {
            targetContentOffset.pointee = scrollView.contentOffset
            if velocity.x > 0 {
            if (UIView.appearance().semanticContentAttribute == .forceRightToLeft) {
               self.currentPage = self.currentPage - 1
            } else {
               self.currentPage = self.currentPage + 1
             }
            } else if velocity.x < 0 {
                if (UIView.appearance().semanticContentAttribute == .forceRightToLeft) {
                    self.currentPage = self.currentPage + 1
                } else {
                    self.currentPage = self.currentPage - 1
                }

            }
            moveType = .topBarScrollMove
            changeTopBarViewFrame()

        }

    }
    
    public func moveTo(page: Int, animated: Bool = true) {
        currentPage = page
        self.scrollToPage(page: page, animated: animated)
        updateIndicatorView()
    }
    
    
    func scrollToPage(page: Int, animated: Bool) {
        currentPage = page
        var frame: CGRect = self.barcontainer.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.barcontainer.scrollRectToVisible(frame, animated: animated)
        
    }
    
}

extension TabBarContainerViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == barcontainer {
            moveType = .containerScrollMove
            currentPage = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
            changeTopBarViewFrame()
            updateIndicatorView()
        }
        
    }
}

extension TabBarContainerViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vc = viewControllers[indexPath.row] as? TabBarDataSourse
        if let vc = vc {
         registerCell(cellIdentifier: vc.cellTabName())
        }
        return (vc?.configureTabCell(collectionView: collectionView, indexpath: indexPath))!
    }
    
}

extension TabBarContainerViewController : UICollectionViewDelegate {
  public   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveType = .topBarSelection
        self.moveTo(page:indexPath.row)
    }
    
}

extension TabBarContainerViewController {
    func getCurrentSortInPage() -> Int {
        
        if (self.numberOfItemsAppearInOnePage >= self.viewControllers.count) {
            return self.currentPage
        }
        
        if(self.currentPage < self.viewControllers.count - self.numberOfItemsAppearInOnePage) {
            return 0
        } else {
            return abs(self.viewControllers.count - self.currentPage - self.numberOfItemsAppearInOnePage)
        }
    }
    
    func getFrameForCurrentCell() -> CGRect? {
        let indexPath = IndexPath(item: self.currentPage, section: 0)
        let rect = self.topBarView.layoutAttributesForItem(at: indexPath)?.frame
        return rect
    }
    
    func setTabBarIndicator(){
        if indictaorPage  == nil {
            indictaorPage  = UIView()
            let cellFrame = getFrameForCurrentCell()
            if let cellFrame = cellFrame {
                indictaorPage!.frame = CGRect(x: cellFrame.origin.x, y: cellFrame.size.height - indicatorHeight, width: cellFrame.size.width, height: indicatorHeight )
                indictaorPage!.backgroundColor = selectedIndicatorColor
                topBarView.addSubview(indictaorPage!)
            }
        }
    }
    
    func updateIndicatorView() {
        if let indictaorPage = indictaorPage {
            UIView.animate(withDuration: 0.3, animations: {
                indictaorPage.backgroundColor = self.selectedIndicatorColor
                let cellFrame = self.getFrameForCurrentCell()
                if let cellFrame = cellFrame {
                    indictaorPage.frame = CGRect(x: cellFrame.origin.x, y: cellFrame.size.height - self.indicatorHeight, width: cellFrame.size.width, height: self.indicatorHeight )
                }
            })
        }
    }
}

