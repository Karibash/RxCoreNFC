//
//  NFCFeliCaTag+Rx.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/26.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

// MARK: - Aliases -

@available(iOS 13.0, *)
public typealias RxNFCFelicaPollingResponse = (tag: NFCFeliCaTag, manufactureParameter: Data, requestData: Data)

@available(iOS 13.0, *)
public typealias RxNFCFelicaRequestServiceResponse = (tag: NFCFeliCaTag, nodes: [Data])

// MARK: - Extensions -

@available(iOS 13.0, *)
extension ObservableType where Element == NFCFeliCaTag {
    
    // MARK: - Commands -
    
    public func polling(
        systemCode: Data,
        requestCode: PollingRequestCode,
        timeSlot: PollingTimeSlot
    ) -> Observable<RxNFCFelicaPollingResponse> {
        flatMap { tag in
            Single.create { observer in
                tag.polling(
                    systemCode: systemCode,
                    requestCode: requestCode,
                    timeSlot: timeSlot
                ) { manufactureParameter ,requestData ,error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success((tag, manufactureParameter, requestData)))
                    }
                }
                return Disposables.create()
            }
        }
    }
    
    public func requestService(nodeCodeList: [Data]) -> Observable<RxNFCFelicaRequestServiceResponse> {
        flatMap { tag in
            Single.create { observer in
                tag.requestService(nodeCodeList: nodeCodeList) { nodes, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success((tag, nodes)))
                    }
                }
                return Disposables.create()
            }
        }
    }
    
}
