//
//  TasksViewController.swift
//  CheddarKit
//
//  Created by Karl Weber on 4/6/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    var list_id: Int = 0
    
    var collectionView: UICollectionView?
    var layout = ListsViewLayout()
    var activeTasks: CDKTasks?
    var archivedTasks: CDKTasks?
    
    convenience init(withListId listId: Int) {
        self.init(nibName: nil, bundle: nil)
        list_id = listId
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        view.backgroundColor = .clear
        setupCollectionView()

//        setupNewTaskInput()
        CheddarKit.sharedInstance.tasks(fromList: list_id, callback: { (tasks, error) in
            if let tasks = tasks {
                self.populateTasks(tasks)
            }
        })
        
    }

    // Setup Functions
    func setupCollectionView() {
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
        collectionView!.register(TaskCell.self, forCellWithReuseIdentifier: cells.task)
        collectionView!.alwaysBounceVertical = true
    }
    
    
    func populateTasks(_ tasks: CDKTasks) {
        print("populatingTasks")
        activeTasks = []; archivedTasks = []
        for task in tasks as Array {
            if task.archived_at == nil { // this task is not archived
//                print("\(task.title)")
                activeTasks?.append(task)
            } else { // this list is archived
                archivedTasks?.append(task)
//                print("These be archived!")
            }
        }
        
        // sort active lists
        let otherTasks = activeTasks?.sorted(by: { (l1, l2) -> Bool in
            l1.position < l2.position
        })
        activeTasks = otherTasks
        
        DispatchQueue.main.sync {
            layout.storedLayouts = nil
            collectionView?.reloadData()
        }
    }

}

extension TasksViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let activeTasks = activeTasks {
            print("total number of activeTasksL \(activeTasks.count)")
            return activeTasks.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.task, for: indexPath)
//        if let activeLists = activeLists {
//            (cell as! ListCell).configure(indexPath: indexPath, list: activeLists[indexPath.row])
//        }
        return cell
    }
    
}

extension TasksViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let activeLists = activeLists {
//            let list = activeLists[indexPath.row]
//            //            func updateList(id: Int, title: String?, archive: Bool?) {
//            CheddarKit.sharedInstance.updateList(id: list.id, title: list.title, archive: true, callback: nil)
//        }
        print("Tapped.")
    }
    
}
