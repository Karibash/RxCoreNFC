//
//  NFCMiFareTag+Rx.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/26.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

@available(iOS 13.0, *)
extension ObservableType where Element == NFCMiFareTag {
    
    // MARK: - Commands -
    
    /// Sends a native MiFare command to the tag.
    /// - Important: For NFCMiFareFamily.ultralight commands, you must calculate a 2-byte CRC value and append it to the end of the command data.
    /// - Parameter commandPacket: A MiFare command.
    /// - Returns: An NSData object containing the tag's response data for the command.
    public func sendMiFareCommand(commandPacket: Data) -> Observable<RxNFCMiFareSendMiFareCommandResult> {
        flatMap { tag in
            Single.create { observer in
                tag.sendMiFareCommand(commandPacket: commandPacket) { data, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success(RxNFCMiFareSendMiFareCommandResult(
                            data: data
                        )))
                    }
                }
                return Disposables.create()
            }
        }
    }
    
    /// Sends an ISO 7816 command APDU to the tag and receives a response APDU.
    /// - Parameter apdu: An ISO 7816-4 command APDU object.
    /// - Returns: An APDU response and command processing status byte.
    public func sendMiFareISO7816Command(apdu: NFCISO7816APDU) -> Observable<RxNFCMiFareSendMiFareISO7816CommandResult> {
        flatMap { tag in
            Single.create { observer in
                tag.sendMiFareISO7816Command(apdu) { data, sw1, sw2, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success(RxNFCMiFareSendMiFareISO7816CommandResult(
                            data: data,
                            sw1: sw1,
                            sw2: sw2
                        )))
                    }
                }
                return Disposables.create()
            }
        }
    }
    
}
