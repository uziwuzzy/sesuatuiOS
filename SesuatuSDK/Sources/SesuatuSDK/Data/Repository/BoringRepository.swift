//
//  BoringRepository.swift
//  TicTacToe
//
//  Created by Wahyu Sulistyo on 09/05/22.
//

import Foundation
import RxSwift

class BoringRepository {
    
    private let boredApi: BoredApi
    
    init(boredApi: BoredApi){
        self.boredApi = boredApi
    }
    
    func getBoringActivity() -> Single<BoringActivity> {
        return boredApi.getBoringActivity()
    }
}
