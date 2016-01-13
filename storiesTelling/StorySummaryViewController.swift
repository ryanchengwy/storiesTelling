//
//  StorySummaryViewController.swift
//  storiesTelling
//
//  Created by Ryan on 6/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit

class StorySummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var storySummaryTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Auto height for the cell
        self.storySummaryTable.rowHeight = UITableViewAutomaticDimension
        self.storySummaryTable.estimatedRowHeight = 50
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: tableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StorySummaryCell", forIndexPath: indexPath)
        
        return cell
    }

}
