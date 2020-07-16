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
public typealias RxNFCFelicaWriteWithoutEncryptionResponse = (statusFlag1: Int, statusFlag2: Int)

@available(iOS 13.0, *)
public typealias RxNFCFelicaRequestSpecificationVersionResponse = (statusFlag1: Int, statusFlag2: Int, basicVersion: Data, optionVersion: Data)

@available(iOS 13.0, *)
public typealias RxNFCFelicaResetModeResponse = (statusFlag1: Int, statusFlag2: Int)

// MARK: - Extensions -

@available(iOS 13.0, *)
extension ObservableType where Element == NFCFeliCaTag {
    
    // MARK: - Commands -
    
    /// Sends the Polling command as defined by FeliCa card specification to the tag.
    /// - Note: Node key version list is return as NSArray of NSData objects, and each data object is stored in Little Endian format per FeliCa specification.
    /// - Parameters:
    ///   - systemCode: System code for the the FeliCa tag to be requested.
    ///   - requestCode: Request code for the data to be requested.
    ///   - timeSlot: The number of FeliCa tags to request.
    /// - Returns: Returns data according to manufacturing parameters and request code.
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
    
    /// Sends the Request Service command, as defined by the FeliCa card specification, to the tag.
    /// - Note: The order of the key versions in the node key version list matches the node code list.
    /// - Important: It is necessary to enumerate and specify area codes or service codes by little endian in the node code list parameter.
    /// - Parameter nodeCodeList: Node code list for the service to be requested.
    /// - Returns: Returns a list of node key versions.
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
    
    /// Sends the Request Service V2 command, as defined by the FeliCa card specification, to the tag.
    /// - Note: The order of the key versions in the node key version list matches the node code list.
    /// - Important: It is necessary to enumerate and specify area codes or service codes by little endian in the node code list parameter.
    /// - Parameter nodeCodeList: Node code list for the service to be requested.
    /// - Returns: Returns a list of cryptographic identifiers and node key versions.
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
    
    /// Sends the Read Without Encryption command, as defined by the FeliCa card specification, to the tag.
    /// - Note: The maximum number of blocks that can be read at the same time is different for each product.
    /// - Important: Do not specify a service code in the service code list that is not referenced from the block list.
    /// - Parameters:
    ///   - serviceCodeList: Service code list for the data to be read.
    ///   - blockList: Block list for the data to be read.
    /// - Returns: Returns the data read.
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
    
    /// Sends the Write Without Encryption command, as defined by the FeliCa card specification, to the tag.
    /// - Note: The maximum number of blocks that can be written at the same time is different for each product.
    /// - Important: Do not specify a service code in the service code list that is not referenced from the block list.
    /// - Parameters:
    ///   - serviceCodeList: Service code list for the data to be written.
    ///   - blockList: Block list for the data to be written.
    ///   - blockData: Block data for the data to be written.
    /// - Returns: Returns the result of the operation.
    public func writeWithoutEncryption(
        serviceCodeList: [Data],
        blockList: [Data],
        blockData: [Data]
    ) -> Observable<RxNFCFelicaWriteWithoutEncryptionResponse> {
        flatMap { tag in
            Single.create { observer in
                 tag.writeWithoutEncryption(
                    serviceCodeList: serviceCodeList,
                    blockList: blockList,
                    blockData: blockData
                 ) { statusFlag1, statusFlag2, error in
                     if error != nil {
                         observer(.error(error!))
                     } else {
                         observer(.success((statusFlag1, statusFlag2)))
                     }
                 }
                 return Disposables.create()
             }
        }
    }
    
    /// Sends the Request Response command, as defined by the FeliCa card specification, to the tag.
    /// - Returns: Returns the current mode of the tag.
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
    
    /// Sends the Request Specification Version command, as defined by the FeliCa card specification, to the tag.
    /// - Returns: Returns the OS version of the tag.
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
    
    /// Sends the Request System Code command, as defined by the FeliCa card specification, to the tag.
    /// - Returns: Returns the system code registered to the card.
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
    
    /// Sends the Reset Mode command, as defined by the FeliCa card specification, to the tag.
    /// - Returns: Returns the result of the operation.
    public func resetMode() -> Observable<RxNFCFelicaResetModeResponse> {
        flatMap { tag in
            Single.create { observer in
                tag.resetMode { statusFlag1, statusFlag2, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success((statusFlag1, statusFlag2)))
                    }
                }
                 return Disposables.create()
             }
        }
    }
    
}
