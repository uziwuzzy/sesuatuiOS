//
//  BoredActivity.swift
//  TicTacToe
//
//  Created by Wahyu Sulistyo on 09/05/22.
//

import Foundation
import RxSwift

struct BoringActivity: Decodable {
    var activity: String?
    var accessibility: Float
    var type: String?
    var participants: Int
    var price: Float
    var link: String?
    var key: String?
    }


@objc
public class BoringResponse : NSObject {
    
    
    @objc public var activity: String?
    @objc public var accessibility: NSNumber?
    @objc public var type: String?
    @objc public var participants: NSNumber?
    @objc public var price: NSNumber?
    @objc public var link: String?
    @objc public var key: String?
    
  init(activity: String?, accessibility: NSNumber?, type: String?, participants: NSNumber?, price: NSNumber?, link: String?, key: String?) {
      self.activity = activity
      self.accessibility = accessibility
      self.type = type
      self.participants = participants
      self.price = price
      self.link = link
      self.key = key
    }
    
}

class ModelMapper {
    
    static func mapToBoringResponse(boringActivity: BoringActivity) -> BoringResponse {
        let mapResult = BoringResponse(activity: boringActivity.activity,
                                       accessibility: boringActivity.accessibility as NSNumber, type: boringActivity.type,
                                       participants: boringActivity.participants as NSNumber, price: boringActivity.price as NSNumber,
                                       link: boringActivity.link, key: boringActivity.key)
        return mapResult
    }
}
