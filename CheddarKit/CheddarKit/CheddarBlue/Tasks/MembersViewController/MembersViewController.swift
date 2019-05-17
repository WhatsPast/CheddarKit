//
//  MembersViewController.swift
//  CheddarKit
//
//  Created by Karl Weber on 8/15/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

/*
    The Members view controller obviously shows members for this list.
    It's kept in the TasksViewController for obvious reasons. Like, because
    The TasksViewController shows the actual tasks for a List.
 */

import UIKit

class MembersViewController: UIViewController {
    
    var list: CDKList?
//    var list_id: Int = 0
    
    var collectionView: UICollectionView?
    var layout = ListsViewLayout()
    
    convenience init(withListId list: CDKList) {
        self.init(nibName: nil, bundle: nil)
        self.list = list
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Members"
        view.backgroundColor = .clear

//        CheddarKit.sharedInstance.members(inList: list!, callback: { result in
//            switch result {
//            case .success(let members):
//                DispatchQueue.main.async {
//                    self.populateMembers(members)
//                }
//            case .failure(let error):
//                print("Error: \(error.localizedDescription).")
//            }
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func populateMembers(_ members: CDKMembers) {
        print("populatingMembers")
        
        
//        activeTasks = []; archivedTasks = []
//        for task in tasks as Array {
//            if task.archived_at == nil { // this task is not archived
//                //                print("\(task.title)")
//                activeTasks?.append(task)
//            } else { // this task is archived
//                archivedTasks?.append(task)
//                //                print("These be archived!")
//            }
//        }
//
//        // sort active lists
//        let otherTasks = activeTasks?.sorted(by: { (l1, l2) -> Bool in
//            l1.position < l2.position
//        })
//        activeTasks = otherTasks
//
//        DispatchQueue.main.sync {
//            layout.storedLayouts = nil
//            collectionView?.reloadData()
//        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
