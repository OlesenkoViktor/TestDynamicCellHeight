//
//  ViewController.swift
//  TestDynamicCellHeight
//
//  Created by Viktor Olesenko on 05.04.17.
//  Copyright © 2017 Viktor Olesenko. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    static let identifier = "identifier"
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var dImageView: UIImageView!
    @IBOutlet var dImageViewHeight: NSLayoutConstraint!
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier) as! Cell
        
        cell.label1.text = "Cell: \(indexPath.row). Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac purus congue, cursus risus ac, congue diam. Nunc aliquet ipsum vitae enim condimentum posuere."
        
        cell.label2.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac purus congue, cursus risus ac, congue diam. Nunc aliquet ipsum vitae enim condimentum posuere."
        
        cell.dImageView.image = nil
        cell.dImageViewHeight.constant = 100
        DispatchQueue.global().async {
            let imageUrl = URL(string: "https://beebom.com/wp-content/uploads/2016/01/Reverse-Image-Search-Engines-Apps-And-Its-Uses-2016.jpg")!
            
            let data = try! Data(contentsOf: imageUrl)
            let image = UIImage(data: data)!
            
            
            let newHeight = (cell.dImageView.bounds.width / image.size.width) * image.size.height
            
            DispatchQueue.main.async {
                cell.dImageView.image = image
                cell.dImageViewHeight.constant = newHeight
            }
        }
        
        return cell
    }
}

