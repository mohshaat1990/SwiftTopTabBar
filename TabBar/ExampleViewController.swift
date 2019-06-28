//
//  ExampleViewController.swift
//  TabBar
//
//  Created by Mohamed Shaat on 6/21/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {

    var examples = ["Title","Title With Image","Image Only", "Custom Cell", "Not Fill Width"]
    var tabShouldFillWidth = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "exampletabBar" {
            var cellName:String = TabBarCollectionViewCellTitle.resusableName
            let index: Int = sender as! Int
            switch index {
            case 0 :
            cellName = TabBarCollectionViewCellTitle.resusableName
             tabShouldFillWidth = true
            case 1 :
            cellName = TabBarCollectionViewCellTitleWithImage.resusableName
             tabShouldFillWidth = true
            case 2 :
            cellName = TabBarCollectionViewCellImage.resusableName
             tabShouldFillWidth = true
            case 3 :
            cellName = CustomTabViewCell.resusableName
            tabShouldFillWidth = true
            case 4 :
            cellName = TabBarCollectionViewCellTitleWithImage.resusableName
            tabShouldFillWidth = false
            default:
            cellName = TabBarCollectionViewCellTitle.resusableName
            }
            let destination = segue.destination as? TabBarViewController
            destination?.cellName = cellName
            destination?.tabShouldFillWidth = tabShouldFillWidth
        }
    }
    
}

extension ExampleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = examples[indexPath.row]
        cell.textLabel?.textAlignment = .left
        return cell
    }
    
}

extension ExampleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "exampletabBar", sender: indexPath.row)
    }
}
