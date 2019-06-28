//
//  SlideViewControllerCustomTabCell.swift
//  TabBar
//
//  Created by mohamed shaat on 6/23/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

class SlideViewControllerCustomTabCell: UIViewController, TabBarDataSourse {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func cellTabName() -> String {
        return CustomTabViewCell.resusableName
    }
    
    func configureTabCell(collectionView: UICollectionView, indexpath:IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellTabName(), for: indexpath) as! CustomTabViewCell
        //cell.titleLabel.text = "\(indexpath.row)"
        return cell
    }

}
