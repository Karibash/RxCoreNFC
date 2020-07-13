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
public typealias RxNFCFelicaPollingResponse = (manufactureParameter: Data, requestData: Data)

@available(iOS 13.0, *)
public typealias RxNFCFelicaRequestServiceV2Response = (statusFlag1: Int, statusFlag2: Int, encryptionIdentifier: EncryptionId, nodeKeyVersionListAES: [Data], nodeKeyVersionListDES: [Data])

@available(iOS 13.0, *)
public typealias RxNFCFelicaReadWithoutEncryptionResponse = (statusFlag1: Int, statusFlag2: Int, dataList: [Data])

@available(iOS 13.0, *)
public typealias RxNFCFelicaRequestSpecificationVersionResponse = (statusFlag1: Int, statusFlag2: Int, basicVersion: Data, optionVersion: Data)

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
                        observer(.success((manufactureParameter, requestData)))
                    }
                }
                return Disposables.create()
            }
        }
    }
    
    public func requestService(nodeCodeList: [Data]) -> Observable<[Data]> {
        flatMap { tag in
            Single.create { observer in
                tag.requestService(
                    nodeCodeList: nodeCodeList
                ) { nodes, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success((nodes)))
                    }
                }
                return Disposables.create()
            }
        }
    }
    
    public func requestServiceV2(nodeCodeList: [Data]) -> Observable<RxNFCFelicaRequestServiceV2Response> {
        flatMap { tag in
            Single.create { observer in
                tag.requestServiceV2(
                    nodeCodeList: nodeCodeList
                ) { statusFlag1, statusFlag2, encryptionIdentifier, nodeKeyVersionListAES, nodeKeyVersionListDES, error  in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success((statusFlag1, statusFlag2, encryptionIdentifier, nodeKeyVersionListAES, nodeKeyVersionListDES)))
                    }
                }
                return Disposables.create()
            }
        }
    }
    
    public func readWithoutEncryption(serviceCodeList: [Data], blockList: [Data]) -> Observable<RxNFCFelicaReadWithoutEncryptionResponse> {
        flatMap { tag in
            Single.create { observer in
                tag.readWithoutEncryption(
                    serviceCodeList: serviceCodeList,
                    blockList: blockList
                ) { statusFlag1, statusFlag2, dataList, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success((statusFlag1, statusFlag2, dataList)))
                    }
                }
                return Disposables.create()
            }
        }
    }
    
    public func requestResponse() -> Observable<Int> {
        flatMap { tag in
            Single.create { observer in
                 tag.requestResponse { mode, error in
                     if error != nil {
                         observer(.error(error!))
                     } else {
                         observer(.success(mode))
                     }
                 }
                 return Disposables.create()
             }
        }
    }
    
    public func requestSpecificationVersion() -> Observable<RxNFCFelicaRequestSpecificationVersionResponse> {
        flatMap { tag in
            Single.create { observer in
                 tag.requestSpecificationVersion { statusFlag1, statusFlag2, basicVersion, optionVersion, error in
                     if error != nil {
                         observer(.error(error!))
                     } else {
                         observer(.success((statusFlag1, statusFlag2, basicVersion, optionVersion)))
                     }
                 }
                 return Disposables.create()
             }
        }
    }
    
    public func requestSystemCode() -> Observable<[Data]> {
        flatMap { tag in
            Single.create { observer in
                tag.requestSystemCode { systemCodeList, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success(systemCodeList))
                    }
                }
                 return Disposables.create()
             }
        }
    }
    
}
