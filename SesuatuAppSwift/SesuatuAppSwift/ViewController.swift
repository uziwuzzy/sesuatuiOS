//
//  ViewController.swift
//  SesuatuAppSwift
//
//  Created by Muhammad Fauzi Masykur on 12/05/22.
//

import UIKit
import SesuatuSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func startSDKPressed(_ sender: Any) {
        var sesuatuSDK = SesuatuSDK()
        sesuatuSDK.fetchDataFromApi { result, error in
            if (result != nil) {
                print("datanya \(result?.activity)")
            } else {
                print("error")
            }
        }
    }
}

