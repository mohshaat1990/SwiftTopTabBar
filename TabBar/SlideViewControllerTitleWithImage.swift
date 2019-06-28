//
//  SlideViewControllerTitleWithImage.swift
//  TabBar
//
//  Created by mohamed shaat on 6/23/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

class SlideViewControllerTitleWithImage: UIViewController, TabBarDataSourse {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func cellTabName() -> String {
        return TabBarCollectionViewCellTitleWithImage.resusableName
    }
    
    func configureTabCell(collectionView: UICollectionView, indexpath:IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellTabName(), for: indexpath) as! TabBarCollectionViewCellTitleWithImage
        cell.imageView.image = UIImage(named:"icon_productTabBarItem_active")
        cell.titleLabel.text = "\(indexpath.row)"
        return cell
    }

}
