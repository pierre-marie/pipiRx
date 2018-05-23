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

class ToiletViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var map: MKMapView!

    lazy var viewModel : ToiletViewModel = {
        let viewModel = ToiletViewModel()
        return viewModel
    }()

    @IBAction func buttonClicked(_ sender: Any) {
        self.viewModel.fetchToilets()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.viewModel.toilets
            .subscribe(onNext: { [weak self] toilets in
                // Manage UI for every toilets value changes
                print("onNext -> toilets: \(toilets.count)")
            }).disposed(by: disposeBag)
        
        self.viewModel.fetchToilets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
