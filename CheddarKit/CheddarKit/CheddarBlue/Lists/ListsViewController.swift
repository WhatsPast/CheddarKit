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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Lists"
        
        view.backgroundColor = .clear
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
//        print("Frame width: \(self.view.frame.width)")
        
        collectionView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView!)
        collectionView!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        collectionView!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        collectionView!.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0).isActive = true
        collectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0).isActive = true
        
        
//        layout.estimatedItemSize = CGSize(width: self.view.frame.width, height: 44.0)
        collectionView!.frame = self.view.frame
        self.view.addSubview(collectionView!)
        collectionView!.dataSource = self
        collectionView!.backgroundColor = .blue
        collectionView!.register(ListCell.self, forCellWithReuseIdentifier: cells.listCell)
        collectionView!.alwaysBounceVertical = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// Datasource stuff
extension ListsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.listCell, for: indexPath)
//        (cell as! ListCell).configure()
        
        return cell
    }
    
}

