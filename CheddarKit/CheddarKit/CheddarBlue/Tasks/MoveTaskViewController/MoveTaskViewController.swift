//
//  MoveTaskViewController.swift
//  CheddarKit
//
//  Created by Karl Weber on 4/14/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

class MoveTaskViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var layout = ListsViewLayout()
    var activeLists: CDKLists?
    var task_id = 0
    var task: CDKTask?
    
    convenience init(withTask task: CDKTask) {
        self.init(nibName: nil, bundle: nil)
        task_id = task.id
        self.task = task
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Move Task"
        view.backgroundColor = .clear
        setupCollectionView()
        CheddarKit.sharedInstance.lists(callback: { (lists, error) in
            print("It worked")
            if let lists = lists {
                self.populateLists(lists)
            } else {
                print("We actually didn't get lists.")
            }
            return nil
        })
    }
    
    func setupCollectionView() {
        layout.delegate = self
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        print("Frame width: \(self.view.frame.height)")
        
        collectionView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView!)
        collectionView!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        collectionView!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        collectionView!.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        collectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        
        collectionView!.frame = self.view.frame
        self.view.addSubview(collectionView!)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.backgroundColor = .white
        collectionView!.register(MoveTaskListCell.self, forCellWithReuseIdentifier: cells.moveTaskLlist)
        collectionView!.alwaysBounceVertical = true
    }

    func populateLists(_ lists: CDKLists) {
        print("populatingLists")
        activeLists = []
        for list in lists as Array {
            if list.archived_at == nil { // this list is not archived
                print("\(list.title) [\(list.active_uncompleted_tasks_count)]")
                activeLists?.append(list)
            }
        }
        
        // sort active lists
        let otherLists = activeLists?.sorted(by: { (l1, l2) -> Bool in
            l1.position < l2.position
        })
        activeLists = otherLists
        
        DispatchQueue.main.sync {
            layout.storedLayouts = nil
            collectionView?.reloadData()
        }
    }

}

// Datasource stuff
extension MoveTaskViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let activeLists = activeLists {
            return activeLists.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.moveTaskLlist, for: indexPath)
        if let activeLists = activeLists {
            (cell as! MoveTaskListCell).configure(indexPath: indexPath, list: activeLists[indexPath.row])
        }
        return cell
    }
    
}

extension MoveTaskViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let activeLists = activeLists {
            let list = activeLists[indexPath.row]
            CheddarKit.sharedInstance.move(task: task!, toList: list, callback: { (task, error) in
                if task != nil {
                    print("MOVED THE TASK!!!! YAY!")
                } else {
                    print("something went wrong when moving the task.")
                }
            })
        }
    }

}

extension MoveTaskViewController: ListsViewLayoutDelegate {
    
    func textFor(indexPath: IndexPath) -> String {
        if let activeLists = activeLists {
            let list = activeLists[indexPath.row]
            return list.title
        }
        return ""
    }
    
    func numberofItems() -> Int {
        if let activeLists = activeLists {
            return activeLists.count
        }
        return 0
    }
    
}
