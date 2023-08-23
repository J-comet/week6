//
//  LocationViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/22.
//

import UIKit
import CoreLocation  // 1. 위치 임포트
import MapKit

class LocationViewController: UIViewController {

    // 2. 위치매니저 생성 : 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()

    let mapView = MKMapView()
    let midSchoolButton = UIButton()
    let elemetSchoolButton = UIButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = "네비바 타이틀 영역"
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(50)
        }
        view.backgroundColor = .white
        
        midSchoolButton.backgroundColor = .green
        view.addSubview(midSchoolButton)
        midSchoolButton.addTarget(self, action: #selector(midSchoolButtonClicked), for: .touchUpInside)
        midSchoolButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.leading.equalTo(10)
            make.size.equalTo(50)
        }
        
        elemetSchoolButton.backgroundColor = .red
        view.addSubview(elemetSchoolButton)
        elemetSchoolButton.addTarget(self, action: #selector(elemantSchoolButtonClicked), for: .touchUpInside)
        elemetSchoolButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.trailing.equalTo(-10)
            make.size.equalTo(50)
        }
        
        // 3. 위치 프로토콜 연결
        locationManager.delegate = self
        
        /**
         Info.plist 에서 설정한 것과 같은 것을. 선택해야됨
         */
//        locationManager.requestWhenInUseAuthorization()
        
        // 인스턴스가 생성될 때 호출되기떄문에 두번호출될 수 있음 -> 그냥 ViewDidLoad 에서 권한체크 확인하기!!!
        // 하지만 네비게이션이나 탭바 컨트롤러로 임베디드되면 권한변경 메서드가 인스턴스 생성될 때 호출이 안됨!!
        // 따라서 호출 필요
        checkDeviceLocationAuthorization()
        let center = CLLocationCoordinate2D(latitude: 37.5344, longitude: 126.8845)
        setRegionAndAnnotation(center: center)
        
        setAnnotation(type: 0)
    }
    
    @objc
    func midSchoolButtonClicked() {
        print("중딩 클릭")
        setAnnotation(type: 2)
    }
    
    @objc
    func elemantSchoolButtonClicked() {
        print("초딩 클릭")
        setAnnotation(type: 1)
    }
    
    func setAnnotation(type: Int) {
        // 37.519690, 126.887686 - 영문초
        // 37.520134, 126.884242 - 문래중
        let annotation1 = MKPointAnnotation()
        let center1 = CLLocationCoordinate2D(latitude: 37.519690, longitude: 126.887686)
        annotation1.title = "영문초"
        annotation1.coordinate = center1
        
        let annotation2 = MKPointAnnotation()
        let center2 = CLLocationCoordinate2D(latitude: 37.520134, longitude: 126.884242)
        annotation2.title = "문래중"
        annotation2.coordinate = center2
        
        if type == 0 {
            mapView.addAnnotations([annotation1,annotation2])
        } else if type == 1 {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations([annotation1])
        } else {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations([annotation2])
        }
    }
    
    // 마커?
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
//        let center = CLLocationCoordinate2D(latitude: 37.5344, longitude: 126.8845)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(region, animated: true)
        
        // 지도에 어노테이션 추가
        let annotation = MKPointAnnotation()
        annotation.title = "타이틀"
        annotation.coordinate = center
        
        mapView.addAnnotation(annotation)
    }
    
    func showLocationSettingAlert() {
        print(UIApplication.openSettingsURLString)
        
        let alert = UIAlertController(title: "위치 서비스", message: "설정 > 개인정보 보호에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        // 설정에서 직접적으로 앱 설정 화면에 들어간 적이 없다면
        // 한번도 설정 앱에 들어가지 않았거나, 막 다운받은 앱이라서 앱 상세까지 못들어간다.
        
        // 유저가 들어간 적이 있다면 앱 상세까지 자동으로 이동됨.
        let goSetting = UIAlertAction(title: "이동", style: .default) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(goSetting)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func checkDeviceLocationAuthorization() {
        
        DispatchQueue.global().async {
            
            // locationServicesEnabled - 메인스레드에서 체크하면 안됨.
            // 아이폰 설정에서 위치서비스 확인 (gps설정 확인)
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    print("authorization = \(authorization)")
                    self.checkCurrentLocationAuthorization(status: authorization)
                }

            } else {
                print("아이폰 위치서비스가 꺼져있으면 위치 권한요청을 할 수 없음")
            }
        }
        
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print("stats =",status)
        
        switch status {
        case .notDetermined:
//            print("최초로 앱을 유저가 실행했을 때")
            print(#function, "\(status)")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest  // 위치 정확도 설정
            locationManager.requestWhenInUseAuthorization()  // 얼럿을 띄워주는 역할 - info.plist 에 알맞은 권한 명시해줘야 얼럿 동작
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            // iOS 설정으로 보내라는 alert 띄우기
            showLocationSettingAlert()
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            //didUpDateLocationr
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default:   // 위치 권한 종류가 추후에 더 생길 가능성을 대비해준 것
            print("default")
        }
    }
}

// 4. 프르토콜 선언
extension LocationViewController: CLLocationManagerDelegate {
    
    // 5. 사용자의 위치를 성공적으로 가지고 온 경우
    // 한번만 실행되는 것이 아니라 위치가 계속 바뀌면 계속 호출됨 , iOS 위치 업데이트가 필요한 시점에 알아서 여러번 호출!!
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function ,locations)
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            setRegionAndAnnotation(center: coordinate)
        }
        // 위치 업데이트 그만하고 싶을 때
        locationManager.stopUpdatingLocation()
    }
    
    // 6. 사용자의 위치를 못가지고 왔을 경우 (사용자의 권한거부시에도 호출 됨)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, error.localizedDescription)
    }

    // 7. 사용자의 권한 상태가 바뀔 때를 얄려줌 (iOS 14 이상)
    // 거부했다가 설정에서 변경을 했거나 ,notDetermained 상태에서 허용을 했거나
    // 허용해서 위치를 가지고 오는 도중에 설정에서 거부를 하고 앱으로 다시 돌아올 때
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 어떤 권한인지는 모르고 권한이 바뀌는 것만 암,
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
    // iOS14 - Deprecated
    // 7. 사용자의 권한 상태가 바뀔 때를 얄려줌 (iOS 14 미만)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
     
        print(#function, status)
    }
}



extension LocationViewController : MKMapViewDelegate {
    
    // 지도가 움직인 후 멈추면 호출됨
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(#function)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//    }
}
