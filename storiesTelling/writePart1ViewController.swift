//
//  writePart1ViewController.swift
//  storiesTelling
//
//  Created by Ryan on 10/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit

class writePart1ViewController: UIViewController {

    @IBOutlet weak var wordscountLabel: UILabel!
    @IBOutlet weak var writeContentPart1: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        writeContentPart1.layer.borderColor = UIColor.lightGrayColor().CGColor
        writeContentPart1.layer.borderWidth = 1
        writeContentPart1.layer.cornerRadius = 5
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
