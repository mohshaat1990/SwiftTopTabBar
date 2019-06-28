//
//  TabBarCollectionViewCellTitleWithImage.swift
//  TabBar
//
//  Created by mohamed shaat on 6/10/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

public class TabBarCollectionViewCellTitleWithImage: UICollectionViewCell {
    public static let resusableName = String(describing: TabBarCollectionViewCellTitleWithImage.self)
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}
