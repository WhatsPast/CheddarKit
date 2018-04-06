//
//  TasksViewController.swift
//  CheddarKit
//
//  Created by Karl Weber on 4/6/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var layout = ListsViewLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        view.backgroundColor = .clear
        setupCollectionView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        collectionView!.register(ListCell.self, forCellWithReuseIdentifier: cells.listCell)
        collectionView!.alwaysBounceVertical = true
    }

}

extension TasksViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let activeLists = activeLists {
//            return activeLists.count
//        } else {
            return 0
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.listCell, for: indexPath)
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
