//
//  ViewController.swift
//  Milestone3
//
//  Created by Rosalyn Kingsmill on 2017-08-06.
//  Copyright © 2017 Rosalyn Kingsmill. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var groceryItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGroceryItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sendList))
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = groceryItems[indexPath.row]
        return cell
    }
    
    //MARK: Helper Methods
    
    func addGroceryItem() {
        let ac = UIAlertController(title: "Add Item", message: "Add your new shopping item to your list", preferredStyle: .alert)
        ac.addTextField()
        let add = UIAlertAction(title: "Add", style: .default) { [unowned self]  (action: UIAlertAction) in
            let item = ac.textFields![0]
            //put new item at first index of the array
            self.groceryItems.insert(item.text!, at: 0)
            //insert the new first item inthe array at the top of the list
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(add)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    func sendList() {
        let list = groceryItems.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true)
    }
}

