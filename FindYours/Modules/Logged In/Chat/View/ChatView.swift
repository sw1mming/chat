//
//  ChatView.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/7/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit
import UITextView_Placeholder

class ChatView: UIView {
    
    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.keyboardDismissMode = .onDrag
        table.separatorStyle = .none

        return table
    }()
    
    var bottomContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.black.cgColor
        
        return view
    }()
    
    var inputTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .lightGray
        textView.placeholder = "Enter message..."
        textView.isScrollEnabled = false
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        
        return textView
    }()
    
    var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        
        return button
    }()
    
    deinit {
        print("!!! ChatView deinit !!!")
    }
    
    init() {
        super.init(frame: .zero)
        
        addSubview(tableView)
        addSubview(bottomContainerView)
        bottomContainerView.addSubview(inputTextView)
        bottomContainerView.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            bottomContainerView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            bottomContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomContainerView.heightAnchor.constraint(lessThanOrEqualToConstant: inputTextView.font!.lineHeight * 10),
            bottomContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            
            inputTextView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 10),
            inputTextView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 10),
            inputTextView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor, constant: -10),
            
            confirmButton.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 5),
            confirmButton.widthAnchor.constraint(equalToConstant: 50),
            confirmButton.leadingAnchor.constraint(equalTo: inputTextView.trailingAnchor, constant: 5),
            confirmButton.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -5),
            confirmButton.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor, constant: -5),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEnableConfirmButton() {
        confirmButton.isEnabled = !inputTextView.text.isEmptyOrWhitespace
    }
    
    func clearTextView() {
        inputTextView.text = ""
        setEnableConfirmButton()
    }
}
