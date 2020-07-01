//
//  NFCTagReaderSession+Rx.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/25.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

@available(iOS 13.0, *)
extension Reactive where Base: NFCTagReaderSession {
    static func open(pollingOption: NFCTagReaderSession.PollingOption) -> Observable<RxNFCTagReaderSession> {
        Observable
              .create { observer in
                  let session = RxNFCTagReaderSession(pollingOption: pollingOption)
                  observer.on(.next(session))
                  return Disposables.create()
              }
              .share(replay: 1, scope: .whileConnected)
    }
}
