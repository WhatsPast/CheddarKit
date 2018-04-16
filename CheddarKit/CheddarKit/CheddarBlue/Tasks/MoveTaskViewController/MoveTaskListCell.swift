//
//  MoveTaskListCell.swift
//  CheddarKit
//
//  Created by Karl Weber on 4/14/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

/*
    This cell is exclusively for the move task VC.
    It's just a selection.
 */

class MoveTaskListCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let border     = UIView()
    let activeTasksLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.frame = frame
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        
        // title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.text = "Whatever"
        
        // border
        border.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(border)
        border.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0.0).isActive = true
        border.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -0.0).isActive = true
        border.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        border.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        border.backgroundColor = .whiteFour
        
        let randomView = UIView()
        //        randomView.frame = CGRect(x: 10, y: 10, width: 30, height: 16)
        randomView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(randomView)
        randomView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0).isActive = true
        randomView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
        randomView.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        randomView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        randomView.layer.cornerRadius = 4.0
        randomView.backgroundColor = .whiteFour
        
        
        // Task Number
        activeTasksLabel.translatesAutoresizingMaskIntoConstraints = false
        activeTasksLabel.font = UIFont.systemFont(ofSize: 10.0, weight: .regular)
        activeTasksLabel.textAlignment = .center
        activeTasksLabel.backgroundColor = .clear
        activeTasksLabel.layer.cornerRadius = 4.0
        activeTasksLabel.textColor = .blackThree
        contentView.addSubview(activeTasksLabel)
        activeTasksLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0).isActive = true
        activeTasksLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
        activeTasksLabel.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        activeTasksLabel.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        activeTasksLabel.text = "0"
        
        self.contentView.backgroundColor = .white
    }
    
    func configure(indexPath: IndexPath, list: CDKList) {
        border.backgroundColor = .whiteFour
        if indexPath.row == 0 {
            border.backgroundColor = .white
        }
        titleLabel.text = list.title
        activeTasksLabel.text = "\(list.active_uncompleted_tasks_count)"
        activeTasksLabel.layer.cornerRadius = 4.0
    }
    
}
