//
//  ViewController.swift
//  SwiftExample
//
//  Created by 爱写代码的小马 on 2021/9/15.
//

import Cocoa

class ViewController: NSViewController, MSSegmentedControlDelegate {

    @IBOutlet weak var sMenuCtl:MSSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        var items = [MSSegmentedControlItem]()
        items.append(MSSegmentedControlItem.initWithTitle("Menu Style"))
        items.append(MSSegmentedControlItem.initWithTitle("Button Style"))
        sMenuCtl.items = items
        sMenuCtl.displayStyle = MSSCDisplayStyle.menu
        sMenuCtl.displayIfNeeded()
        sMenuCtl.delegate = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func selected(_ ctl: MSSegmentedControl, index: Int) {
        print("selected is \(index)")
    }


}
 
