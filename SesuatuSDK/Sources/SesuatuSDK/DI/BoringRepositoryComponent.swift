//
//  BoringRepositoryComponent.swift
//  TicTacToe
//
//  Created by Wahyu Sulistyo on 11/05/22.
//

import Foundation
import NeedleFoundation

protocol BoringRepositoryDependency: Dependency {
    var boredRequestAdapter: BoredRequestAdapter { get }
}

class BoringRepositoryComponent: Component<BoringRepositoryDependency>, BoringRepositoryBuilder{

    var boringRepository: BoringRepository {
        return BoringRepository(boredApi: boredApi)
    }
    
    var boredApi: BoredApi {
        return BoredApi(interceptor: dependency.boredRequestAdapter)
    }
    
}

// Use a builder protocol to allow mocking for unit tests. At the same time,
// this allows LoggedOutViewController to be initialized lazily.
protocol BoringRepositoryBuilder {
    var boringRepository: BoringRepository { get }
}
