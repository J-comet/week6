//
//  GenericViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/24.
//

import UIKit
import SnapKit

class GenericViewController: UIViewController {
    
    let testLabel = {
        let view = UILabel()
        view.text = "제네릭테스트"
        view.backgroundColor = .yellow
        return view
    }()
    
    let testButton = {
        let view = UIButton()
        view.setTitle("테스트", for: .normal)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "제네릭 네비바"
        view.backgroundColor = .lightGray

        let genericSum = sum(a: 3.5, b: 3)
        let genericSum2 = sum(a: 5, b: 10)
        print(genericSum)
        print(genericSum2)
        
        let result = sumInt(a: 3, b: 7)
        print(result)
        
        let doubleResult = sumDouble(a: 3.5, b: 7.1)
        print(doubleResult)
        
        let floatResult = sumFloat(a: 2.2, b: 1.1)
        print(floatResult)
     
        view.addSubview(testLabel)
        configureBorder(view: testLabel)
        testLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        view.addSubview(testButton)
        configureBorder(view: testButton)
        testButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }

}
