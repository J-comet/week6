//
//  SnapViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/22.
//

import UIKit
import SnapKit


/**
 1. addSubView 위치
 2. superView 어떤 뷰안에서 넣을지
 3. offset inset
 4. RTL
 */
class SnapViewController: UIViewController {
    
    let redView = UIView()
    let whiteView = UIView()
    let blueView = UIView()
    let yellowView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        /**
         addSubview 순서대로 뷰가 추가되기 때문에
         순서가 중요!!
         */
        view.addSubview(redView)
        redView.backgroundColor = .red
        redView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(150)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(whiteView)
        
        whiteView.backgroundColor = .white
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)  // leading + trailing
            make.height.equalTo(200)
        }
        
        view.addSubview(blueView)
        blueView.backgroundColor = .blue
        blueView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(200)
//            make.width.height.equalTo(200)        // width + height
        }
        
        blueView.addSubview(yellowView)
        yellowView.backgroundColor = .yellow
        yellowView.snp.makeConstraints { make in
//            make.size.equalTo(150)
//            make.leading.top.equalToSuperview()
            make.edges.equalToSuperview().inset(50)  // leading, trailing, top, bottom 한꺼번에할 때 edge 사용
            // inset 안으로, offset 모두 밀어내기
//            make.edges.equalTo(blueView)
            
        }
        
    }

}
