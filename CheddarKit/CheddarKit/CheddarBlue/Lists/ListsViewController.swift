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
    var activeLists: [CDKList]?
    var archivedLists: [CDKList]?
    var newListInput = TextField()
    var newListDelegate = NewListDelegate()
    
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
    }
    
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
        collectionView!.register(ListCell.self, forCellWithReuseIdentifier: cells.listCell)
        collectionView!.alwaysBounceVertical = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        newListInput.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0).isActive = true
        newListInput.heightAnchor.constraint(equalToConstant: 36).isActive = true
        newListInput.backgroundColor = .whiteThree
        newListInput.layer.cornerRadius = 13.0
        newListInput.delegate = newListDelegate
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
//            func updateList(id: Int, title: String?, archive: Bool?) {
            CheddarKit.sharedInstance.updateList(id: list.id, title: list.title, archive: true, callback: nil)
        }
    }
    
}
