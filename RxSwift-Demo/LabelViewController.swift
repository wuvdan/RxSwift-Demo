//
//  LabelViewController.swift
//  RxSwift-Demo
//
//  Created by wudan on 2020/5/8.
//  Copyright © 2020 wudan. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class LabelViewController: UIViewController {
        
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UILabel"
        view.backgroundColor = .white
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 19)
        label.textColor = .darkGray
        label.text = "00:00:00"
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        // 创建定时器，绑定到label的text属性上
        Observable<Int>
        .interval(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance)
        .map {
            String(format: "%0.2d:%0.2d:%0.2d",
            arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10])
        }
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
    }
}
