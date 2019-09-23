//
//  TestViewController.swift
//  ios11大标题和下拉刷新
//
//  Created by 廖佩志 on 2019/9/23.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class TestViewController: BaseViewController {

    var tableView: UITableView?
    var largeLabel: UILabel?
    var titleLabel: UILabel?
    var titleString: String = "hahahjjjjjjjjjjjjjjjjjjjjjjjhjjjjjjjjjjjjjjjjjjjjjjhjjjjjjjjjjjjjjjjjjjjjjhjjjjjjjjjjjjjjjjjjjjjjhjjjjjjjjjjjjjjjjjjjjjj"
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: self.view.bounds)
        tableView?.backgroundColor = .white
        tableView?.refreshControl = UIRefreshControl()
        tableView?.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "TestViewController")
//        self.title = "ssss"
        let titleView = UIView(frame: CGRect(x: 0, y: -100, width: (self.tableView?.bounds.width)!, height: 44))
        titleLabel = UILabel()
        titleLabel?.text = titleString
        titleLabel?.sizeToFit()
        titleView.addSubview(titleLabel!)
        navigationItem.titleView = titleView

//        navigationItem.titleView?.frame = CGRect(x: 0, y: -100, width: 200, height: 44)


        //
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        
        largeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView?.bounds.width ?? 0 , height: 80))
        largeLabel?.text = titleString
        largeLabel?.numberOfLines = 0
        headView.addSubview(largeLabel!)
//         headView.backgroundColor = .red
        tableView?.tableHeaderView = headView
        //
        view.addSubview(tableView!)
//        if #available(iOS 11.0, *) {
                    navigationItem.largeTitleDisplayMode = .never
//                    self.extendedLayoutIncludesOpaqueBars = true
//            self.navigationController?.navigationBar.isTranslucent = false
//                    self.edgesForExtendedLayout = UIRectEdge()
//                    tableView?.contentInsetAdjustmentBehavior = .never
//                }


    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
//            self.title = ""
        }else {
//            self.title = "ssss"
//            self.navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        }

//        makeLargeTitleLabelTransfrom(scrollView: scrollView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    @objc func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView?.refreshControl?.endRefreshing()
        }
    }


    ///label
    func makeLargeTitleLabelTransfrom(scrollView: UIScrollView) {
//        titleLabel
//        var flag = false
//        print( scrollView.contentOffset.y)
        let offsetY = scrollView.contentOffset.y
//        if offsetY > 0 {
//
//        }
//        CGAffineTransform.identity.scaledBy(x: -2, y: 0)
//
//        titleLabel?.transform = CGAffineTransform.identity.scaledBy(x: 10, y: 0)

        var fromValue: CGPoint = CGPoint(x: 0, y: -44)
//        let toValue: CGPoint = CGPoint(x: 100, y: 0)
//        let y = 0
//        let to = CGPoint(x: 0, y: y)
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = fromValue
        fromValue.y += min(0, -44+offsetY)
        animation.toValue = fromValue
//        animation.duration = 1
        navigationItem.titleView?.layer.add(animation, forKey: "position")
    }
}

extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestViewController", for: indexPath)
        cell.textLabel?.text = "1"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let testB = TestBViewController()
        self.navigationController?.pushViewController(testB, animated: true)
    }

//    func setTitle() {
//        for navItem in (self.navigationController?.navigationBar.subviews)! {
//            for itemSubView in navItem.subviews {
//                if let largeLabel = itemSubView as? UILabel {
//                    largeLabel.text = self.title
//                    largeLabel.numberOfLines = 0
//                    largeLabel.lineBreakMode = .byWordWrapping
//                }
//            }
//        }
//        navigationController?.navigationBar.setNeedsLayout()
//        navigationController?.navigationBar.layoutIfNeeded()
//    }

}


//extension UINavigationBar {
//    open override func layoutSubviews() {
//        super.layoutSubviews()
//        if #available(iOS 11, *) {
//            for navItem in self.subviews {
//                for itemSubView in navItem.subviews {
//                    if let largeLabel = itemSubView as? UILabel {
//                        largeLabel.numberOfLines = 0
//                        largeLabel.lineBreakMode = .byWordWrapping
//                    }
//                }
//            }
//        }
//    }
//}

//extension UIViewController {
//
//func setupNavigationMultilineTitle() {
//    guard let navigationBar = self.navigationController?.navigationBar else { return }
//    for sview in navigationBar.subviews {
//        for ssview in sview.subviews {
//            guard let label = ssview as? UILabel else { break }
//            if label.text == self.title {
//                label.numberOfLines = 0
//                label.lineBreakMode = .byWordWrapping
//                label.sizeToFit()
//                UIView.animate(withDuration: 0.3, animations: {
//                    navigationBar.frame.size.height = 57 + label.frame.height
//                })
//            }
//        }
//    }
//}
//}
