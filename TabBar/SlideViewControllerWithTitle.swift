//
//  SlideViewController.swift
//  TabBar
//
//  Created by Mohamed Shaat on 5/25/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

class SlideViewControllerWithTitle: UIViewController, TabBarDataSourse  {
    @IBOutlet weak var slideLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func cellTabName() -> String {
        return TabBarCollectionViewCellTitle.resusableName
    }
    
    func configureTabCell(collectionView: UICollectionView, indexpath:IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellTabName(), for: indexpath) as! TabBarCollectionViewCellTitle
        cell.titleLabel.text = "\(indexpath.row)"
        self.slideLabel.text = "\(indexpath.row)"
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
