//
//  TaskCell.swift
//  CheddarKit
//
//  Created by Karl Weber on 4/11/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

class TaskCell: UICollectionViewCell {
    
//    let checkButton = UIButton() // this will be customized up the wazoo like crazy talk.
    let textLabel = UILabel()
    let border = UIView()
    let checkBox = CheckButtonViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.frame = frame
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        
        // checkButton
//        checkButton.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(checkButton)
//        checkButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
//        checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
//        checkButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
//        checkButton.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        checkBox.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(checkBox.view)
        checkBox.view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0).isActive = true
        checkBox.view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
        checkBox.view.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        checkBox.view.widthAnchor.constraint(equalToConstant: 36.0).isActive = true
        
        
        // title
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)
        textLabel.leftAnchor.constraint(equalTo: checkBox.view.rightAnchor, constant: 6.0).isActive = true
        textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -6.0).isActive = true
        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textLabel.textColor = .black
        textLabel.textAlignment = .left
        textLabel.text = "Whatever"
        
        // border
        border.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(border)
        border.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0.0).isActive = true
        border.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -0.0).isActive = true
        border.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        border.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        border.backgroundColor = .whiteFour
        
        self.contentView.backgroundColor = .white
    }
    
    func configure(indexPath: IndexPath, task: CDKTask) {
        border.backgroundColor = .whiteFour
        if indexPath.row == 0 {
            border.backgroundColor = .white
        }
        textLabel.text = task.display_text
    }
    
}



