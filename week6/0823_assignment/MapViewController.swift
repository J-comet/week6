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
    
    //MARK: - 디자인 START
    let mapView = {
        let view = MKMapView()
        view.showsUserLocation = true
        return view
    }()
    //MARK: - 디자인 END
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configNavBar()
        designVC()
        
        LocationHelper.shared.locationManager.delegate = self
        
        // 최초 진입시 GPS 확인
        checkGPSAuth()
        
        TheaterList.mapAnnotations.forEach { theater in
            addMarker(theater: theater, type: .all)
        }
        
        // 모든 annotation 표시
        mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    @objc
    func filterClicked() {
        showSheet()
    }
    
    func showRequestLocationServiceAlert() {
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
        LocationHelper.shared.deviceLoactionStatus { gps, authStatus in
            switch gps {
            case .on:
                print("==== 123 ====")
                if let authStatus {
                    self.checkLocationAuth(status: authStatus)
                }
                
            case .off:
                print("==== 456 ====")
                self.updateMapViewCenter(
                    lat: Theater.defaultAnnotaion.latitude,
                    lng: Theater.defaultAnnotaion.longitude
                )
                self.showRequestLocationServiceAlert()
            }
        }
    }
    
    func checkLocationAuth(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined, 권한 결정되지 않음")
            LocationHelper.shared.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            LocationHelper.shared.locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted, 자녀보호기능으로 제한")
        case .denied:
            print("denied, 거부")
            self.updateMapViewCenter(
                lat: Theater.defaultAnnotaion.latitude,
                lng: Theater.defaultAnnotaion.longitude
            )
            showRequestLocationServiceAlert()
        case .authorizedAlways, .authorizedWhenInUse:
            print("authorizedAlways, authorizedWhenInUse")
            LocationHelper.shared.locationManager.startUpdatingLocation()
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
        Theater.TheaterType.allCases.forEach { type in
            if type == .none {
                // foreach 에서는 return 이 continue 효과
                return
            }
            let action = UIAlertAction(title: type.rawValue, style: .default) { _ in
                // 선택한 타입만 보이도록 하기
                self.mapView.removeAnnotations(self.mapView.annotations)
                TheaterList.mapAnnotations.forEach { theater in
                    self.addMarker(theater: theater, type: type)
                }
                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            }
            sheet.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        sheet.addAction(cancelAction)
        present(sheet, animated: true)
    }
    
    func designVC() {
        setMapView()
        self.updateMapViewCenter(
            lat: Theater.defaultAnnotaion.latitude,
            lng: Theater.defaultAnnotaion.longitude
        )
    }
    
    func setMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func updateMapViewCenter(lat: Double, lng: Double) {
        let center = CLLocationCoordinate2D(
            latitude: lat,
            longitude: lng
        )
        let region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: CLLocationDistance(exactly: 5000)!,
            longitudinalMeters: CLLocationDistance(exactly: 5000)!
        )
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    func addMarker(theater: Theater, type: Theater.TheaterType) {
        let center = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(region, animated: true)
        // 지도에 어노테이션 추가
        let annotation = MKPointAnnotation()
        annotation.title = theater.location
        annotation.coordinate = center
        
        if type == .all {
            mapView.addAnnotation(annotation)
        } else {
            if theater.type == type {
                mapView.addAnnotation(annotation)
            }
        }
        
        
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function ,locations)
        if let coordinate = locations.last?.coordinate {
            print("=====", coordinate, "=====")
            self.updateMapViewCenter(
                lat: coordinate.latitude,
                lng: coordinate.longitude
            )
        }
        LocationHelper.shared.locationManager.stopUpdatingLocation()
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
