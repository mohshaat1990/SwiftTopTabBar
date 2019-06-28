//
//  ViewController.swift
//  TabBar
//
//  Created by Mohamed Shaat on 5/25/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit
class TabBarViewController: TabBarContainerViewController{
    @IBOutlet weak var barView: UICollectionView!
    @IBOutlet weak var container: UIScrollView!
    var tabShouldFillWidth = true
    var cellName:String = TabBarCollectionViewCellTitle.resusableName
    override func viewDidLoad() {
       setupTabBar()
       super.viewDidLoad()
    }
    
    func setupTabBar() {
        self.topBarView = barView
        self.barcontainer = container
        self.tabBarShouldFillWidth = tabShouldFillWidth
        self.tabBarWidth = 70
        self.indicatorHeight = 3
        self.selectedIndicatorColor = UIColor.green
        switch cellName {
        case TabBarCollectionViewCellTitle.resusableName:
            self.setupTabBar(viewControllers: getViewControllers(type: SlideViewControllerWithTitle.self))
        case TabBarCollectionViewCellImage.resusableName:
            self.setupTabBar(viewControllers: getViewControllers(type: SlideViewControllerWithImage.self))
        case TabBarCollectionViewCellTitleWithImage.resusableName:
            self.setupTabBar(viewControllers: getViewControllers(type: SlideViewControllerTitleWithImage.self))
        case CustomTabViewCell.resusableName:
             self.setupTabBar(viewControllers: getViewControllers(type: SlideViewControllerCustomTabCell.self))
        default:
            self.setupTabBar(viewControllers: getViewControllers(type: SlideViewControllerTitleWithImage.self))
        }
        
        self.moveTo(page: 0)
    }
    
    func getViewControllers<T>(type: T.Type)->[T] {
        var count = 3
        if tabShouldFillWidth == false {
            count = 10
        }
        var viewControllers = [T]()
        for _ in 1...count {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing:type)) as? T
            viewControllers.append(vc!)
        }
        return viewControllers
    }
    
}

