//
//  ToiletViewController.swift
//  pipi
//
//  Created by pierre-marie de jaureguiberry on 5/23/18.
//  Copyright © 2018 vo2. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class ToiletViewController: UIViewController, MKMapViewDelegate {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var toiletSwitch: UISwitch!
    
    lazy var viewModel : ToiletViewModel = {
        let viewModel = ToiletViewModel()
        return viewModel
    }()

    @IBAction func switchValueChanged(_ sender: Any) {
        self.viewModel.switchValueChanged(switchIsOn: toiletSwitch.isOn)
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        
        toiletSwitch.setOn(false, animated: true)
        self.viewModel.fetchToilets()
    }
    
    func redrawMapAnnotations(toilets: Array<Toilet>) {
        map.removeAnnotations(map.annotations)
        map.addAnnotations(self.viewModel.fetchToiletAnnotations())
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "t411")
        }
        
        return annotationView
    }
    
    func centerMapOn(location: CLLocation) {

        let span = MKCoordinateSpanMake(0.0275, 0.0275)
        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        map.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        UserLocationManager.shared.determineCurrentLocation()
        
        self.viewModel.toilets
            .subscribe(onNext: { [weak self] toilets in
                print("onNext -> toilets: \(toilets.count)")
                self?.redrawMapAnnotations(toilets: toilets as! Array<Toilet>)
            }).disposed(by: disposeBag)
        
        UserLocationManager.shared.userLocation
            .subscribe(onNext: { userLocation in
                print("onNext -> user location: \(userLocation)")
                self.centerMapOn(location: userLocation)
            }).disposed(by: disposeBag)
        
        toiletSwitch.setOn(false, animated: true)
        self.viewModel.fetchToilets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
