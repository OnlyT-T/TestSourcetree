//
//  ViewController.swift
//  GoogleMapDemo
//
//  Created by Tran Thanh Trung on 02/09/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    
    var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        return _locationManager
        
    }()
    
    var camera:  GMSCameraPosition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hàm yêu cầu quyền truy cập
        locationManager.requestWhenInUseAuthorization()
        // gán delegate
        locationManager.delegate = self
        // bật vị trí trên map
        mapView.isMyLocationEnabled = true
    }

}

extension ViewController: CLLocationManagerDelegate{
    // thay đổi quyền truy cập
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .denied:
            print("Quyền truy cập bị từ chối")
            break
        case .restricted:
            print("Quyền truy cập bị hạn chế")
            break
        default:
            fatalError()
        }
    }
    
    // hàm này cập nhật toạ độ người dùng
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else {
                return
            }

            camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), zoom: 10)
            locationManager.stopUpdatingLocation()
            print("Lat: \(coordinate.latitude) - Long: \(coordinate.longitude)")
        }
}


