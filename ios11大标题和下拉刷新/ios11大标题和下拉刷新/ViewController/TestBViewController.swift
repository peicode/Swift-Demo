//
//  TestBViewController.swift
//  ios11大标题和下拉刷新
//
//  Created by 廖佩志 on 2019/10/30.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class TestBViewController: UIViewController {
    var titleLabel: UILabel?
    var titleLabel2: UILabel?
    var tableView: UITableView?
    var largeLabel = UILabel()
    var flag = true
    var largeTitleLabelHeight: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: self.view.bounds)
        tableView?.backgroundColor = .white
//        tableView?.refreshControl = UIRefreshControl()
//        tableView?.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "TestViewController")
        view.addSubview(tableView!)
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = UIRectEdge()

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 44))
        titleLabel = UILabel()
        titleLabel?.text = "I'm Title!"
        titleLabel?.textAlignment = .center
        titleLabel?.sizeToFit()
        titleLabel?.backgroundColor = .yellow
        self.titleLabel?.alpha = 0
        titleView.addSubview(titleLabel!)
        titleView.backgroundColor = .red
        navigationItem.titleView = titleView
        titleLabel!.frame = CGRect(x: 20, y: 10, width: 200, height: 44)
//
//        titleLabel2 = UILabel()
//        titleLabel2?.text = "I'm Title!"
//        titleLabel2?.textAlignment = .center
//        titleLabel2?.sizeToFit()
//        titleView.addSubview(titleLabel2!)
//        titleLabel!.frame = CGRect(x: 20, y: 0, width: 200, height: 44)

        // headView
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        largeLabel = UILabel(frame: CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: 0))
        headView.addSubview(largeLabel)
        largeLabel.numberOfLines = 0
        largeLabel.text = "patientFolderListViewModel.projectInfo.folderName,patientFolderListViewModel.projectInfo.folderName,patientFolderListViewModel.projectInfo.folderName"
        largeLabel.font = UIFont(name: "PingFangSC-Medium", size: 24)
        largeLabel.lineBreakMode = .byWordWrapping
        largeLabel.sizeToFit()
        headView.bounds = largeLabel.bounds
//        headView.bounds.height = largeLabel.bounds.height
        largeTitleLabelHeight = largeLabel.bounds.height
        tableView?.tableHeaderView = headView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        changeTitleLabel(scrollView)
        useAppStoreAnimation(scrollView)
    }

    //transform仿射变换
    func changeTitleLabel(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        print("offsety----||||\(offSetY)")
        let scale = 44.0 / largeTitleLabelHeight

        let height = max(-44, -offSetY*scale)
        titleLabel?.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1).translatedBy(x: 1, y: height)
    }

    // 本来想用hero，后来一想不适合，还是用的App store一样的动画；并不适合我们项目的动画
    func useAppStoreAnimation(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > largeTitleLabelHeight - 15 && titleLabel?.alpha == 0 {
            UIView.animate(withDuration: 0.2) {
                self.titleLabel?.frame = CGRect(x: 20, y: 0, width: 200, height: 44)
                self.titleLabel?.alpha = 1
                self.largeLabel.alpha = 0
            }
        } else if offsetY <= largeTitleLabelHeight - 15 && titleLabel?.alpha == 1 {
            UIView.animate(withDuration: 0.2) {
                self.titleLabel?.frame = CGRect(x: 20, y: 10, width: 200, height: 44)
                self.titleLabel?.alpha = 0
                self.largeLabel.alpha = 1
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TestBViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
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
}
