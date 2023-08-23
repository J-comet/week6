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
        view.showsUserLocation = true
        return view
    }()
    //MARK: 디자인 END
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configNavBar()
        designVC()
        
        locationManager.delegate = self
        
        // 최초 진입시 GPS 확인
        checkGPSAuth()
    }
    
    @objc
    func filterClicked() {
        showSheet()
    }
    
    func showRequestLocationServiceAlert() {
        //        print(URL(string: UIApplication.openSettingsURLString))
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
    func checkGPSAuth() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                // 위치 서비스 사용 가능
                print("위치 서비스 사용 O")
                var authorization: CLAuthorizationStatus
                
                // iOS 14 버전부터 위치권한 변경
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    // 현재 위치 권한 상태 체크
                    self.checkLocationAuth(status: authorization)
                }
                
            } else {
                // 위치 서비스 사용 불가능
                print("위치 서비스 사용 X")
                DispatchQueue.main.async {
                    self.defaultMapCenter()
                    self.showRequestLocationServiceAlert()
                }
                
            }
        }
    }
    
    func checkLocationAuth(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined, 권한 결정되지 않음")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted, 자녀보호기능으로 제한")
        case .denied:
            print("denied, 거부")
            defaultMapCenter()
            showRequestLocationServiceAlert()
        case .authorizedAlways, .authorizedWhenInUse:
            print("authorizedAlways, authorizedWhenInUse")
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
            /**
             이 승인을 통해 앱 사용 여부에 관계없이 모든 위치 서비스를 사용하고 위치 이벤트를 수신할 수 있습니다.
             */
        @unknown default:
            print("ERROR")
        }
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
        defaultMapCenter()
    }
    
    func setMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func defaultMapCenter() {
        let center = CLLocationCoordinate2D(
            latitude: Theater.defaultAnnotaion.latitude,
            longitude: Theater.defaultAnnotaion.longitude
        )
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: CLLocationDistance(exactly: 1000)!, longitudinalMeters: CLLocationDistance(exactly: 1000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function ,locations)
        if let coordinate = locations.last?.coordinate {
            print("=====", coordinate, "=====")
            
        }
    }
    
    // 사용자의 권한 상태 바뀔 때 알려줌 (iOS 14 미만)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuth(status: status)
    }
    
    //    사용자의 GPS 상태가 바뀔 때를 얄려줌 (iOS 14 이상))
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, manager.authorizationStatus)
        checkGPSAuth()
    }
}
