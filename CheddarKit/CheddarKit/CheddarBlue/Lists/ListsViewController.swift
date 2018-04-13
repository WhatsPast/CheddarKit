//
//  ListsViewController.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/11/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit

class ListsViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var layout = ListsViewLayout()
    var activeLists: CDKLists?
    var archivedLists: CDKLists?
    var newListInput = TextField()
    var newListDelegate = NewListDelegate()
    
    // for moving cells
    var longPress = UILongPressGestureRecognizer()
    var snapshot: UIView?
    var sourceIndexPath: IndexPath?
    var dontrecognizeMovement = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lists"
        view.backgroundColor = .clear
        setupCollectionView()
        setupNewListInput()
        CheddarKit.sharedInstance.lists(callback: { (lists, error) in
            print("It worked")
            if let lists = lists {
                self.populateLists(lists)
            } else {
                print("We actually didn't get lists.")
            }
            return nil
        })
        
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized))
        self.collectionView?.addGestureRecognizer(longPress)
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
        collectionView!.register(ListCell.self, forCellWithReuseIdentifier: cells.listCell)
        collectionView!.alwaysBounceVertical = true
    }
    
    func populateLists(_ lists: CDKLists) {
        print("populatingLists")
        activeLists = []; archivedLists = []
        for list in lists as Array {
            if list.archived_at == nil { // this list is not archived
                print("\(list.title) [\(list.active_uncompleted_tasks_count)]")
                activeLists?.append(list)
            } else { // this list is archived
                archivedLists?.append(list)
//                print("These be archived!")
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
    
    func setupNewListInput() {
        newListInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newListInput)
        newListInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        newListInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true
        newListInput.heightAnchor.constraint(equalToConstant: 36).isActive = true
        newListInput.backgroundColor = .whiteThree
        newListInput.layer.cornerRadius = 13.0
        newListInput.delegate = newListDelegate
        newListDelegate.textField = newListInput
        newListDelegate.setupConstraints()
    }

}

// Datasource stuff
extension ListsViewController: UICollectionViewDataSource {
    
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
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.listCell, for: indexPath)
        if let activeLists = activeLists {
            (cell as! ListCell).configure(indexPath: indexPath, list: activeLists[indexPath.row])
        }
        return cell
    }
    
}

extension ListsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let activeLists = activeLists {
            let list = activeLists[indexPath.row]
            // open taskViewController
            let taskVC = TasksViewController(withListId: list.id)
            self.navigationController?.pushViewController(taskVC, animated: true)
        }
    }
    
}


// Long Press to move this stuff things.
extension ListsViewController {
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
                UIView.animate(withDuration: 0.25, delay:0.0, options:UIViewAnimationOptions(), animations: {
                    
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
                
                var reorderedLists = activeLists!
                let element = reorderedLists.remove(at: self.sourceIndexPath!.row)
                reorderedLists.insert(element, at: indexPath!.row)
                
                var index: Int = 0
                for _ in reorderedLists {
                    reorderedLists[index].position = index
                    index = index + 1
                }
                print("Reordering.....")
                CheddarKit.sharedInstance.reorder(lists: reorderedLists, callback: nil)
                activeLists = reorderedLists
                
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
            
            UIView.animate(withDuration: 0.25, delay:0.0, options:UIViewAnimationOptions(), animations: {
                
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

extension ListsViewController: ListsViewLayoutDelegate {
    
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
