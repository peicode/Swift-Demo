//
//  TestTableViewController.swift
//  ios11大标题和下拉刷新
//
//  Created by 廖佩志 on 2019/9/17.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {

    override func viewDidLoad() {


        super.viewDidLoad()
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.title = "具体项目"

        let v = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        v.backgroundColor = .red
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: v)
//        navigationItem.hidesBackButton = true
//        navigationItem.backBarButtonItem
//        if (self.navigationItem.leftBarButtonItems?.contains(self.navigationItem.backBarButtonItem))! {
//            self.navigationItem.leftBarButtonItems.remove(at: 0)
//            self.navigationItem.setLeftBarButtonItems(leftBarButtonItems, animated: false)
//        }
//        if leftBarButtonItems.count == 0 {
//            self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: UIView()), animated: true)
//        }
//        self.navigationController?.navigationBar.backItem = UINavigationItem(title: "ddd")
        let bar = UINavigationBar.appearance()
        bar.setBackgroundImage(UIImage(named: "icon_search1.png"), for: .bottom, barMetrics: .default)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: v)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = "1"
        return cell
    }

}
