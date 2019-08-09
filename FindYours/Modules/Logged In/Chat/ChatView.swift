//
//  ChatView.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/7/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class ChatView: UIView {
    
    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var inputTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(tableView)
        addSubview(inputTextView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
            inputTextView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            inputTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            inputTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            inputTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
