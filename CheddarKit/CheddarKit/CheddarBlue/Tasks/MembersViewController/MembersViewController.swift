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
    
    var members: CDKMembers?
    
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
        
        setupCollectionView()

        CheddarKit.sharedInstance.members(inList: list!, callback: { result in
            switch result {
            case .success(let members):
                DispatchQueue.main.async {
                    self.populateMembers(members)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription).")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func populateMembers(_ members: CDKMembers) {
        print("populatingMembers")
        self.members = members

//        DispatchQueue.main.sync {
//            layout.storedLayouts = nil
//            collectionView?.reloadData()
//        }
    }
    
    /*
     // MARK: - CollectionViewDelegate
     */
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MembersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let allMembers = members?.members {
            print("total number of members \(allMembers.count)")
            return allMembers.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.task, for: indexPath)
        if let allMembers = members?.members {
            (cell as! MemberCell).configure(indexPath: indexPath, member: allMembers[indexPath.row])
        }
        return cell
    }
    
}

extension MembersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let activeTasks = activeTasks {
//            let task = activeTasks[indexPath.row]
//
//            //            CheddarKit.sharedInstance.update(task: task, withText: nil, archive: true, complete: nil, callback: { (task, error) in
//            //                if task != nil {
//            //                    print("Archived a task")
//            //                    print("\(task!.list_id):\(task!.id) - \(task!.text)")
//            //                }
//            //            })
//
//            let moveVC = MoveTaskViewController(withTask: task)
//            self.navigationController?.pushViewController(moveVC, animated: true)
//
//        }
        print("Tapped.")
    }
    
}

extension MembersViewController: ListsViewLayoutDelegate {
    
    func textFor(indexPath: IndexPath) -> String {
        if let allMembers = members?.members {
            let member = allMembers[indexPath.row]
            return member.username
        }
        return ""
    }
    
    func numberofItems() -> Int {
        if let allMembers = members?.members {
            return allMembers.count
        }
        return 0
    }
    
}
