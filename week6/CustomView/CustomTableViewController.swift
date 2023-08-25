//
//  CustomTableViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/24.
//

import UIKit
import SnapKit

struct Sample {
    let text: String
    var isExpand: Bool
}

class CustomTableViewController: UIViewController {
    
    // viewDidLoad 보다 클로저 구문이 먼저 실행됨.
    // lazy var 로 지연초기화를 이용해서 CustomTableViewController
    // 인스턴스 생성이후에 tableView 를 초기화시켜서 self 키워드 사용
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.dataSource = self
        view.delegate = self
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        return view
    }()
    
    let imageView = {
        // 여기서 frame 으로 CGRect 로 작성이 되더라도 제약조건으로 크기가 다시 지정됨
        let view = PosterImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return view
    }()
    
    var list: [Sample] = [
        Sample(text: "ㅁㅇㅁㄴㅇㄴㅇㅁㄴㅇㄴㅁㅇㅁㄴㅇㅁ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴㅇㅁㅇ,ㅁㄴㅇ,ㅁㄴㅇ,ㅁ,ㄴㅇ,ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴ,ㅇㅁㄴㅇ,ㅁㄴㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇ,ㅁㄴㅇ,ㅁㄴ,ㅇㅁㄴㅇ,ㄴㅁㅇ,ㄴㅁㅇ,ㅁㄴㅇ,ㅁㄴㅇ,ㅁㄴㅇ,ㅁㄴㅇ,ㄴㅁㅇㅁㄴㅇㅁㄴㅇㅁㄴ,ㅇㅁㄴㅇ,ㅁㄴㅇ,ㅁㄴ,ㅇㅁㄴㅇㅁㄴㅇ,ㅁㄴㅇ", isExpand: false),
        Sample(text: "good", isExpand: false),
        Sample(text: "1234ㅁㅇㅁㄴㅇㄴㅇㅁㄴㅇㄴㅁㅇㅁㄴㅇㅁ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴㅇㅁㅇ,ㅁㄴㅇ,ㅁㄴㅇ,ㅁ,ㄴㅇ,ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴ,ㅇㅁㄴㅇ,ㅁㄴㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇㅁㄴ,ㅇ,ㅁㄴㅇ,ㅁㄴ,ㅇㅁㄴㅇ,ㄴㅁㅇ,ㄴㅁㅇ,ㅁㄴㅇ,ㅁㄴㅇ,ㅁㄴㅇ,ㅁㄴㅇ,ㄴㅁㅇㅁㄴㅇㅁㄴㅇㅁㄴ,ㅇㅁㄴㅇ,ㅁㄴㅇ,ㅁㄴ,ㅇㅁㄴㅇㅁㄴㅇ,ㅁㄴㅇ", isExpand: false)
    ]
//    var isExpand = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            print("snpsnp")
            make.size.equalTo(200)
            make.center.equalToSuperview()
        }
    }
}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.titleLabel.text = list[indexPath.row].text
        cell.titleLabel.numberOfLines = list[indexPath.row].isExpand ? 0 : 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list[indexPath.row].isExpand.toggle()
//        isExpand.toggle()
        
        // 특정 섹션, 로우 업데이트 하고 싶을 때 직접 입력 IndexPath(row: 3, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
