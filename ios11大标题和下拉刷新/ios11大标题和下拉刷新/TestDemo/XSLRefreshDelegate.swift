//
//  XSLRefreshDelegate.swift
//  ios11大标题和下拉刷新
//
//  Created by 廖佩志 on 2019/9/17.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

public class XSLRefreshDelegate: NSObject, UITableViewDelegate {
    weak public var tableView: UITableView?

    fileprivate var refreshControl: UIRefreshControl = UIRefreshControl()

    fileprivate var indicatorStyle: UIActivityIndicatorView.Style = .gray

    fileprivate var indicatorView : UIActivityIndicatorView


    public init(tableView: UITableView) {
        self.tableView = tableView

        if #available(iOS 13.0, *) {
            //获取当前主题，改变indicatorStyle
        }
        self.indicatorView = UIActivityIndicatorView(style: indicatorStyle)
        super.init()
        setupUI()
        self.tableView?.delegate = self
    }

    fileprivate func setupUI() {

        tableView?.refreshControl = refreshControl
        refreshControl.addTarget(tableView, action: #selector(handleRefresh), for: .valueChanged)

        indicatorView.startAnimating()
        let footerView = UITableViewHeaderFooterView(reuseIdentifier: "footer")
        footerView.addSubview(indicatorView)
        footerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        indicatorView.center = footerView.center
        tableView?.tableFooterView = footerView

    }

    @objc fileprivate func handleRefresh() {
        defer {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.refreshControl.endRefreshing()
            }
        }

        pulldownRefresh()
    }

    public func pulldownRefresh() {

    }
}
