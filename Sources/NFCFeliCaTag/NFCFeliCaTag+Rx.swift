//
//  NFCFeliCaTag+Rx.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/26.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

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
    ) -> Observable<RxNFCFeliCaPollingResult> {
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
                        observer(.success(RxNFCFeliCaPollingResult(
                            manufactureParameter: manufactureParameter,
                            requestData: requestData
                        )))
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
    public func requestService(nodeCodeList: [Data]) -> Observable<RxNFCFeliCaRequestServiceResult> {
        flatMap { tag in
            Single.create { observer in
                tag.requestService(
                    nodeCodeList: nodeCodeList
                ) { nodes, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success(RxNFCFeliCaRequestServiceResult(
                            nodeKeyVersionList: nodes
                        )))
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
    public func requestServiceV2(nodeCodeList: [Data]) -> Observable<RxNFCFeliCaRequestServiceV2Result> {
        flatMap { tag in
            Single.create { observer in
                tag.requestServiceV2(
                    nodeCodeList: nodeCodeList
                ) { statusFlag1, statusFlag2, encryptionIdentifier, nodeKeyVersionListAES, nodeKeyVersionListDES, error  in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success(RxNFCFeliCaRequestServiceV2Result(
                            statusFlag: RxNFCFeliCaStatusFlag(statusFlag1: statusFlag1, statusFlag2: statusFlag2),
                            encryptionIdentifier: encryptionIdentifier,
                            nodeKeyVersionListAES: nodeKeyVersionListAES,
                            nodeKeyVersionListDES: nodeKeyVersionListDES
                        )))
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
    public func readWithoutEncryption(serviceCodeList: [Data], blockList: [Data]) -> Observable<RxNFCFeliCaReadWithoutEncryptionResult> {
        flatMap { tag in
            Single.create { observer in
                tag.readWithoutEncryption(
                    serviceCodeList: serviceCodeList,
                    blockList: blockList
                ) { statusFlag1, statusFlag2, dataList, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success(RxNFCFeliCaReadWithoutEncryptionResult(
                            statusFlag: RxNFCFeliCaStatusFlag(statusFlag1: statusFlag1, statusFlag2: statusFlag2),
                            dataList: dataList
                        )))
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
    ) -> Observable<RxNFCFeliCaWriteWithoutEncryptionResult> {
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
                         observer(.success(RxNFCFeliCaWriteWithoutEncryptionResult(
                            statusFlag: RxNFCFeliCaStatusFlag(statusFlag1: statusFlag1, statusFlag2: statusFlag2)
                         )))
                     }
                 }
                 return Disposables.create()
             }
        }
    }
    
    /// Sends the Request Response command, as defined by the FeliCa card specification, to the tag.
    /// - Returns: Returns the current mode of the tag.
    public func requestResponse() -> Observable<RxNFCFeliCaRequestResponseResult> {
        flatMap { tag in
            Single.create { observer in
                 tag.requestResponse { mode, error in
                     if error != nil {
                         observer(.error(error!))
                     } else {
                        observer(.success(RxNFCFeliCaRequestResponseResult(
                            mode: mode
                        )))
                     }
                 }
                 return Disposables.create()
             }
        }
    }
    
    /// Sends the Request Specification Version command, as defined by the FeliCa card specification, to the tag.
    /// - Returns: Returns the OS version of the tag.
    public func requestSpecificationVersion() -> Observable<RxNFCFeliCaRequestSpecificationVersionResult> {
        flatMap { tag in
            Single.create { observer in
                 tag.requestSpecificationVersion { statusFlag1, statusFlag2, basicVersion, optionVersion, error in
                     if error != nil {
                         observer(.error(error!))
                     } else {
                         observer(.success(RxNFCFeliCaRequestSpecificationVersionResult(
                            statusFlag: RxNFCFeliCaStatusFlag(statusFlag1: statusFlag1, statusFlag2: statusFlag2),
                            basicVersion: basicVersion,
                            optionVersion: optionVersion
                         )))
                     }
                 }
                 return Disposables.create()
             }
        }
    }
    
    /// Sends the Request System Code command, as defined by the FeliCa card specification, to the tag.
    /// - Returns: Returns the system code registered to the card.
    public func requestSystemCode() -> Observable<RxNFCFeliCaRequestSystemCodeResult> {
        flatMap { tag in
            Single.create { observer in
                tag.requestSystemCode { systemCodeList, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success(RxNFCFeliCaRequestSystemCodeResult(
                            systemCodeList: systemCodeList
                        )))
                    }
                }
                 return Disposables.create()
             }
        }
    }
    
    /// Sends the Reset Mode command, as defined by the FeliCa card specification, to the tag.
    /// - Returns: Returns the result of the operation.
    public func resetMode() -> Observable<RxNFCFeliCaResetModeResult> {
        flatMap { tag in
            Single.create { observer in
                tag.resetMode { statusFlag1, statusFlag2, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success(RxNFCFeliCaResetModeResult(
                            statusFlag: RxNFCFeliCaStatusFlag(statusFlag1: statusFlag1, statusFlag2: statusFlag2)
                        )))
                    }
                }
                 return Disposables.create()
             }
        }
    }
    
    /// Sends the FeliCa command packet data to the tag.
    /// - Parameter commandPacket: Command packet for the sent to the FeliCa tag.
    /// - Returns: Returns the result of the operation.
    public func sendFeliCaCommand(commandPacket: Data) -> Observable<RxNFCFeliCaSendFeliCaCommandResult> {
        flatMap { tag in
            Single.create { observer in
                tag.sendFeliCaCommand(commandPacket: commandPacket) { data, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success(RxNFCFeliCaSendFeliCaCommandResult(
                            data: data
                        )))
                    }
                }
                 return Disposables.create()
             }
        }
    }
    
}
