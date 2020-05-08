//
//  ViewController.swift
//  RxSwift-Demo
//
//  Created by wudan on 2020/5/8.
//  Copyright © 2020 wudan. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

let kViewControllerCellId = "ViewController.TableView.CellID"

class ViewController: UIViewController {
        
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.register(UITableViewCell.self, forCellReuseIdentifier: kViewControllerCellId)
        tb.tableFooterView = UIView()
        view.addSubview(tb)
        return tb
    }()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxSwift - Demo"
        
        let items = Observable.just(["UILabel", "UITextField"])
            
        // cell ForRow At IndexPath
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: kViewControllerCellId)!
            cell.selectionStyle = .none
            cell.textLabel?.text = "\(row + 1). " + element
            return cell
        }.disposed(by: disposeBag)
        
        // didSelected At IndexPath
        tableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            switch indexPath.row {
                case 0: self.navigationController?.pushViewController(LabelViewController(), animated: true)
                case 1: self.navigationController?.pushViewController(TextFieldViewController(), animated: true)
                default:
                    break
            }
        }).disposed(by: disposeBag)
        
        // 布局
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
