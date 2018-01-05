//
//  ListCell.swift
//  CheddarKit
//
//  Created by Karl Weber on 1/2/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
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
        titleLabel.text = "Whatever"
        
        // border
        border.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(border)
        border.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15.0).isActive = true
        border.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0).isActive = true
        border.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        border.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        border.backgroundColor = .gray
        
        // Task Number
        activeTasksLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activeTasksLabel)
        activeTasksLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0).isActive = true
        activeTasksLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
        activeTasksLabel.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        activeTasksLabel.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        activeTasksLabel.font = UIFont.systemFont(ofSize: 10.0, weight: .regular)
        activeTasksLabel.textAlignment = .center
        activeTasksLabel.backgroundColor = .gray
        activeTasksLabel.layer.cornerRadius = 15.0
        activeTasksLabel.text = "0"
        
    }
    
//    contentView
    // this will accept a CDKList object to configure
    func configure(indexPath: IndexPath, list: CDKList) {
        border.backgroundColor = .gray
        if indexPath.row == 0 {
            border.backgroundColor = .white
        }
//        titleLabel.text = "Row: \(indexPath.row + 1) "
        titleLabel.text = list.title
        activeTasksLabel.text = "\(list.active_uncompleted_tasks_count)"
    }
    
}



