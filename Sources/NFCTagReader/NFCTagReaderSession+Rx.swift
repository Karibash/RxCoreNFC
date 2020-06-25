//
//  NFCTagReaderSession+Rx.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/25.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

extension Reactive where Base: NFCTagReaderSession {
    static func open(pollingOption: NFCTagReaderSession.PollingOption) -> RxNFCTagReaderSession {
        return RxNFCTagReaderSession(pollingOption: pollingOption)
    }
}
