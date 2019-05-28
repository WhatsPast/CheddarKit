//
//  CommonDefinitions.swift
//  CheddarKit
//
//  Created by Karl Weber on 1/2/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

struct Cells {
    let listCell = "listCell"
    let task = "task"
    let moveTaskList = "moveTaskListCell"
}

let cells = Cells()

let checkMark: String = "✓"

/*
    Handy extension from https://www.swiftbysundell.com/basics/child-view-controllers
    This makes it a bit easier to add and remove child ViewControllers from other VCs.
 */
extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
