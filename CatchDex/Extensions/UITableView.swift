//
//  UITableView.swift
//  CatchDex
//
//  Created by Fernanda Perovano on 25/09/25.
//


import UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T  else {
            fatalError("Could not dequeue \(T.className)")
        }
        return cell
    }
    
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.className)
    }
}

