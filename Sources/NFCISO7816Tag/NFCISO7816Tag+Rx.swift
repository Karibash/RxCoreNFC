//
//  NFCISO7816Tag+Rx.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/26.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

// MARK: - Extensions -

@available(iOS 13.0, *)
extension ObservableType where Element == NFCISO7816Tag {
    
    // MARK: - Commands -
    
    /// Sends an application protocol data unit (APDU) to the tag and receives a response APDU.
    /// - Parameter apdu: An application protocol data unit to send to the tag.
    /// - Returns: An APDU response and command processing status byte.
    public func sendCommand(apdu: NFCISO7816APDU) -> Observable<RxNFCISO7816SendCommandResult> {
        flatMap { tag in
            Single.create { observer in
                tag.sendCommand(apdu: apdu) { data, sw1, sw2, error in
                    if error != nil {
                        observer(.error(error!))
                    } else {
                        observer(.success(RxNFCISO7816SendCommandResult(
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
