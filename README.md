
# SwiftTopTabBar

- crearte tab bar like android material design
- default cells (title ,image,image with title)
- Crearte Custome Cell
- Spport RTL

![ezgif com-video-to-gif-2](https://user-images.githubusercontent.com/11280137/60376099-dc6e1e00-9a0c-11e9-99ee-029ea9596193.gif)

using pods

```bash
  pod 'SwiftTopTabBar' 
```

## Usage

![Screen Shot 2019-06-29 at 1 05 16    AM](https://user-images.githubusercontent.com/11280137/60375714-d7a86a80-9a0a-11e9-93bf-89d59b05bcd1.png)

```swift
import UIKit

// extend  TabBarContainerViewController
class TabBarViewController: TabBarContainerViewController{
}

// call in viewDidLoad()
   func setupTabBar() {
        self.topBarView = barView
        self.barcontainer = container
        self.tabBarShouldFillWidth = tabShouldFillWidth
        self.tabBarWidth = 70
        self.indicatorHeight = 3
        self.selectedIndicatorColor = UIColor.green

        self.moveTo(page: 0)
    }
```

```swift
// to configure tab bar cell  in slide 
  func cellTabName() -> String {
        return TabBarCollectionViewCellImage.resusableName
    }
    
    func configureTabCell(collectionView: UICollectionView, indexpath:IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellTabName(), for: indexpath) as! TabBarCollectionViewCellImage
       cell.imageView.image = UIImage(named:"icon_productTabBarItem_active")
        return cell
    }
```

