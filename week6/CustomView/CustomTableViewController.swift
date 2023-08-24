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
    
    let tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
    }
}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")!
        cell.textLabel?.text = list[indexPath.row].text
        cell.textLabel?.numberOfLines = list[indexPath.row].isExpand ? 0 : 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list[indexPath.row].isExpand.toggle()
//        isExpand.toggle()
        
        // 특정 섹션, 로우 업데이트 하고 싶을 때 직접 입력 IndexPath(row: 3, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
