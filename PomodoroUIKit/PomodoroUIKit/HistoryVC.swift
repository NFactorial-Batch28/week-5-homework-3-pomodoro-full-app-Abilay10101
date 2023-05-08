//
//  HistoryVC.swift
//  PomodoroUIKit
//
//  Created by Arip Khozhbanov on 07.05.2023.
//

import UIKit

class HistoryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "doc"),tag: 2)
    }
}
