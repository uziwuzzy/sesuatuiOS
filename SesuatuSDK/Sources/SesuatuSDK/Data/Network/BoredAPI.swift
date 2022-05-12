//
//  BoredAPI.swift
//  TicTacToe
//
//  Created by Wahyu Sulistyo on 09/05/22.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift

class BoredApi {
    let url = "https://www.boredapi.com/api/activity/"
    
    let session: Session

    init(interceptor: BoredRequestAdapter){
        session = Session(interceptor: interceptor)
    }

    func getBoringActivity() -> Single<BoringActivity> {
        print("dataaaaa")
        return session.rx
            .data(.get, url)
            .map { data -> BoringActivity in
                debugPrint(data)
                print("datanya \(data)")
                let output = try JSONDecoder().decode(BoringActivity.self, from: data)
                return output
            }
            .asSingle()
    }
    
}
