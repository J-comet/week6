//
//  MapViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/23.
//

import UIKit
import SnapKit
import CoreLocation
import MapKit
/**
 1. 위치 시스템 권한 확인
    a. ON 상태, 위치 권한 요청 가능
        i. 권한 허용
            - 위치 데이터 접근 가능
            - 추후 권한을 거부할 경우에 다시 iOS 시스템 에서 설정 유도
        ii. 권한 거부
            - iOS 시스템 설정 유도
    b. OFF 상태, 위치 권한 요청 불가능
        - iOS 시스템 설정 유도
 */

class MapViewController: UIViewController {

    //MARK: 디자인 START
    let mapView = {
        let view = MKMapView()
        return view
    }()
    
    
    //MARK: 디자인 END
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configNavBar()
        designVC()
    }

    @objc
    func filterClicked() {
        showSheet()
    }

    func configNavBar() {
        title = "제목"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterClicked)
        )
        navigationItem.rightBarButtonItem?.tintColor = .gray
    }
    
    func showSheet() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "1번", style: .default)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        sheet.addAction(action)
        sheet.addAction(cancelAction)
        present(sheet, animated: true)
    }

    func designVC() {
        setMapView()
    }
    
    func setMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
