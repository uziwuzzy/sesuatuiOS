import Foundation
import NeedleFoundation
import RxAlamofire
import RxSwift

@objc(SesuatuSDK)
public class SesuatuSDK : NSObject {
    
    let boringRepository : BoringRepository
    let disposeBag = DisposeBag()
    
    @objc
    public override init() {
        registerProviderFactories()
        boringRepository = RootComponent().boringRepositoryComponent.boringRepository
    }
    
    @objc
   public func fetchDataFromApi(completion: @escaping (_ result: BoringResponse?, _ error: Error?) -> Void) {
        boringRepository.getBoringActivity()
//            .observe(on: MainScheduler())
            .subscribe(onSuccess: { boringActivity in
                completion(ModelMapper.mapToBoringResponse(boringActivity: boringActivity), nil)
            }, onFailure: { error in
                completion(nil, error)
            }
            )
            .disposed(by: disposeBag)
    }
}
