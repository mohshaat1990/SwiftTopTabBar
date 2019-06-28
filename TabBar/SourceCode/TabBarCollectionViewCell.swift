//
//  TabBarCollectionViewCell.swift
//  TabBar
//
//  Created by Mohamed Shaat on 5/25/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

class TabBarCollectionViewCell: UICollectionViewCell {
    static let resusableName = String(describing: TabBarCollectionViewCell.self)
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
