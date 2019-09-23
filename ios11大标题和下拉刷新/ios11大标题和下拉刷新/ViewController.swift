//
//  ViewController.swift
//  ios11大标题和下拉刷新
//
//  Created by 廖佩志 on 2019/9/6.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var dataSource: [Int] = []

    let imageView = UIImageView(image: UIImage(named: "icon_search.png"))
    var indicatorView : UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    var scrollViewY: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()

//        let nav = XSLNavigationBar(viewController: self.navigationController!, customRightImage: UIImage(named: "icon_search.png"))
//
//        view.addSubview(nav)
//        self.navigationController?.navigationBar.isHidden = true

        // 有bug
//        navigationController?.navigationBar.isTranslucent = false
        setupUI()
        navigationItem.prompt = "----杏树林----"
        navigationController?.navigationBar.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            print(change?[NSKeyValueChangeKey.newKey])
        }
    }

    deinit {
        navigationController?.navigationBar.removeObserver(self, forKeyPath: "frame")
    }

    func setupUI() {
        for i in 0..<30 {
            dataSource.append(i)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        /// 上拉加载
        indicatorView.startAnimating()
        let footerView = UITableViewHeaderFooterView(reuseIdentifier: "footer")
        footerView.addSubview(indicatorView)
        footerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        indicatorView.center = footerView.center
        tableView.tableFooterView = footerView
//        footerView.center = tableView.center

//        navigationItem.hidesBackButton = true
//        navigationItem.setHidesBackButton(true, animated: true)

        /// 下拉刷新
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)

        /// 大标题
//        navigationController?.navigationBar.backgroundColor = .red
//        navigationController?.navigationBar.isTranslucent = true
        navigationItem.largeTitleDisplayMode = .always
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickSearch))
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(tapGesture)
        title = "病历夹"

        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 18) ?? (Any).self]

        if #available(iOS 11.0, *) {
        
            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 24) ?? (Any).self]
            navigationBar.addSubview(imageView)
            imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.center = navigationBar.center
            imageView.isUserInteractionEnabled = true
            NSLayoutConstraint.activate([
                imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                                 constant: -Const.ImageRightMargin),
                imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                                  constant: -Const.ImageBottomMarginForLargeState),
                imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
                ])
            print(imageView)
        } else {
            // addrightBarbuttonitem

            let rightBarButtonItem = UIBarButtonItem(customView: imageView)
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        }


    }

    @objc func handleRefresh()  {
        // 自带触感反馈（.light）
        //触感反馈 iOS 10
//        if #available(iOS 10, *) {
//            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
//        }
        //处理事件
        tableView.reloadData()
        // 会造成跳动一下
//        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.refreshControl?.endRefreshing()
        }
    }


    @objc func clickSearch() {
        print("hhhh-----search")
    }

    //MARK: DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(dataSource[indexPath.row])
        return cell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let testVC = TestTableViewController()
//        self.navigationController?.pushViewController(testVC, animated: true)

        let vc = TestViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.count-1 {

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                for i in 0...20{
                    self.dataSource.append(i)
                }
                tableView.reloadData()
            }
        }
    }


    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        print("willDisplayFooterView")
        print(section)
        if section == 1 {

        }
    }

    override func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        print("didEndDisplayingFooterView")
        indicatorView.stopAnimating()
        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImage(false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.edgesForExtendedLayout = .all
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showImage(true)
    }
    private func showImage(_ show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.imageView.alpha = show ? 1.0 : 0.0
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        moveAndResizeImageForPortrait()
    }

    //image

    private func moveAndResizeImageForPortrait() {
        guard let height = navigationController?.navigationBar.frame.height else { return }

        print(height)

        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()

        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState

        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()

        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0

        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()

        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)

        imageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }


}




extension ViewController {
    /// WARNING: Change these constants according to your project's design
    private struct Const {
        /// NavigationBarHeight
        static let NavBarHeightSmallState: CGFloat = 44
        static let NavBarHeightLargeState: CGFloat = 96.0
        /// imageHeight
        static let ImageSizeForSmallState: CGFloat = 24
        static let ImageSizeForLargeState: CGFloat = 30
        /// imageMarginBottom
        static let ImageBottomMarginForSmallState: CGFloat = 12
        static let ImageBottomMarginForLargeState: CGFloat = 8

        static let ImageRightMargin: CGFloat = 16

    }
}


extension UINavigationBar {

//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.size.width, height: 200.0)
//    }

}
