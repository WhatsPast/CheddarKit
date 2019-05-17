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
    var newTaskInput = TextField()
    var newTaskDelegate = NewTaskDelegate()
    
    // for moving cells
    var longPress = UILongPressGestureRecognizer()
    var snapshot: UIView?
    var sourceIndexPath: IndexPath?
    var dontrecognizeMovement = false
    
    convenience init(withListId listId: Int) {
        self.init(nibName: nil, bundle: nil)
        list_id = listId
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        view.backgroundColor = .clear
        setupCollectionView()
        setupNewTaskInput()
        CheddarKit.sharedInstance.tasks(fromList: list_id, callback: { result in
            switch result {
            case .success(let tasks):
                print("populateTasks")
                DispatchQueue.main.async {
                    self.populateTasks(tasks)
                }
            case .failure(let error):
                // we got error
                break
            }
        })
     
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized))
        self.collectionView?.addGestureRecognizer(longPress)
    }

    // Setup Functions
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
            } else { // this task is archived
                archivedTasks?.append(task)
//                print("These be archived!")
            }
        }
        
        // sort active lists
        let otherTasks = activeTasks?.sorted(by: { (l1, l2) -> Bool in
            l1.position < l2.position
        })
        activeTasks = otherTasks
        
        DispatchQueue.main.async {
            self.layout.storedLayouts = nil
            self.collectionView?.reloadData()
        }
    }

}

extension TasksViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let activeTasks = activeTasks {
            print("total number of activeTasks \(activeTasks.count)")
            return activeTasks.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.task, for: indexPath)
        if let activeTasks = activeTasks {
            (cell as! TaskCell).configure(indexPath: indexPath, task: activeTasks[indexPath.row])
        }
        return cell
    }
    
    func setupNewTaskInput() {
        newTaskInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newTaskInput)
        newTaskInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        newTaskInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true
        newTaskInput.heightAnchor.constraint(equalToConstant: 36).isActive = true
        newTaskInput.backgroundColor = .whiteThree
        newTaskInput.layer.cornerRadius = 13.0
        newTaskInput.delegate = newTaskDelegate
        newTaskDelegate.list_id = list_id
        newTaskDelegate.textField = newTaskInput
        newTaskDelegate.setupConstraints()
    }
    
}

extension TasksViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let activeTasks = activeTasks {
            let task = activeTasks[indexPath.row]
            
//            CheddarKit.sharedInstance.update(task: task, withText: nil, archive: true, complete: nil, callback: { (task, error) in
//                if task != nil {
//                    print("Archived a task")
//                    print("\(task!.list_id):\(task!.id) - \(task!.text)")
//                }
//            })
            
            let moveVC = MoveTaskViewController(withTask: task)
            self.navigationController?.pushViewController(moveVC, animated: true)
            
        }
        print("Tapped.")
    }
    
}

// Long Press to move this stuff things.
extension TasksViewController {
    /* Animate all them rows to move like crazy talk. */
    @objc func longPressGestureRecognized(sender:UILongPressGestureRecognizer) {
        
        let lp = sender as UILongPressGestureRecognizer
        let state = lp.state
        let location = longPress.location(in: self.collectionView)
        var indexPath = self.collectionView?.indexPathForItem(at: location)
        
        if let path = indexPath {
            // alright, only allow out of bounds when its not changed or began.
            if (path.section != 0) {
                sender.isEnabled = false
                sender.isEnabled = true
                return
            }
        }
        
        switch state {
        case .began:
            if ((indexPath != nil) && (dontrecognizeMovement == false)) {
                
                sourceIndexPath = indexPath!
                
                let cell = self.collectionView?.cellForItem(at: indexPath!)
                snapshot = self.customSnapshotFromView(inputView: cell!)
                
                // Add the Snapshot as a Subview
                var center = cell?.center
                snapshot?.center = center!
                snapshot?.alpha = 0.0
                self.collectionView?.addSubview(snapshot!)
                UIView.animate(withDuration: 0.25, delay:0.0, options:UIView.AnimationOptions(), animations: {
                    
                    center!.y = location.y
                    self.snapshot?.center = center!
                    self.snapshot?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    self.snapshot?.alpha = 0.98
                    
                    cell!.alpha = 0.0
                    
                }, completion: { (isTrue: Bool) in
                    cell!.isHidden = true
                })
                
            }
            break
        case .changed:
            var center = self.snapshot?.center
            center?.y = location.y
            snapshot?.center = center!
            
            // Is destination valid and is it different from source?
            if indexPath == nil { // alright if it's too far out of bounds, send it back!
                indexPath = sourceIndexPath
            }
            if (!(indexPath == sourceIndexPath) && (indexPath!.section < 1)) {
                
                // ... move the rows.
                collectionView?.moveItem(at: self.sourceIndexPath!, to: indexPath!)
                
                var reorderedTasks = activeTasks!
                let element = reorderedTasks.remove(at: self.sourceIndexPath!.row)
                reorderedTasks.insert(element, at: indexPath!.row)
                
                var index: Int = 0
                for _ in reorderedTasks {
                    reorderedTasks[index].position = index
                    index = index + 1
                }
                print("Reordering.....")
                CheddarKit.sharedInstance.reorder(tasks: reorderedTasks, callback: nil)
                activeTasks = reorderedTasks
                
                // ... update data source.
                //                BudgetModel.moveItemIn(budget: budget, from: (sourceIndexPath?.row)!, to: indexPath!.row)
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath!
            }
            break
            
        default:
            // Clean up
            let cell = collectionView?.cellForItem(at: sourceIndexPath!)
            cell?.isHidden = false
            cell?.alpha = 0.0
            
            UIView.animate(withDuration: 0.25, delay:0.0, options:UIView.AnimationOptions(), animations: {
                
                self.snapshot?.center = cell!.center
                self.snapshot?.transform = CGAffineTransform.identity
                self.snapshot?.alpha = 0.0
                
                cell!.alpha = 1.0
                
            }, completion: { (isTrue: Bool) in
                
                self.sourceIndexPath = nil
                self.snapshot?.removeFromSuperview()
                self.snapshot = nil
            })
            break
        }
    }
    
    // Utility function for moving this thing.
    func customSnapshotFromView(inputView: UIView) -> UIView {
        
        // make an image from the input view
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let snapshot = UIImageView(image: image)
        snapshot.layer.masksToBounds = true
        snapshot.layer.cornerRadius = 0.0
        snapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        snapshot.layer.shadowRadius = 5.0
        snapshot.layer.shadowOpacity = 0.4
        
        return snapshot
    }
    
}




extension TasksViewController: ListsViewLayoutDelegate {
    
    func textFor(indexPath: IndexPath) -> String {
        if let activeTasks = activeTasks {
            let task = activeTasks[indexPath.row]
            return task.display_text!
        }
        return ""
    }
    
    func numberofItems() -> Int {
        if let activeTasks = activeTasks {
            return activeTasks.count
        }
        return 0
    }
    
}
