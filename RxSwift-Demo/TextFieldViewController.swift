//
//  TextFieldViewController.swift
//  RxSwift-Demo
//
//  Created by wudan on 2020/5/8.
//  Copyright © 2020 wudan. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class TextFieldViewController: UIViewController {
    
    let textField = UITextField()
    let label = UILabel()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        label.textAlignment = .center
        label.textColor = .red
        label.numberOfLines = 0
        view.addSubview(label)

        textField.borderStyle = .roundedRect
        textField.placeholder = "Input something you want to say..."
        view.addSubview(textField)
        
        textField.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30);
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(45)
        }
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30);
        }
        
        
        textField.rx.text.orEmpty.changed.subscribe { (text) in
         print("Content：\(text)")
        }
        .disposed(by: disposeBag)
     
        // 将输入框输入内容绑定到Label的Text上
        textField.rx.text.orEmpty.asDriver()
        .drive(label.rx.text)
        .disposed(by: disposeBag)
    }
}
