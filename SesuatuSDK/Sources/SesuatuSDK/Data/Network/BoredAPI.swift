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
    
    private static var session: Session? = nil

    init(session: Session){
        if(BoredApi.session == nil) {
            BoredApi.session = session
        }
    }

    func getBoringActivity() -> Single<BoringActivity> {
        print("dataaaaa")
        guard let session = BoredApi.session else {return Single.error(NSError(domain: "ini error ah ilang", code: 42, userInfo: ["ui1":12, "ui2":"val2"] ))}
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
