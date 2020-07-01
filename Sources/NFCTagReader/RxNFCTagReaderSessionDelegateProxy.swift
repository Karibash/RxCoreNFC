//
//  RxNFCTagReaderSessionDelegateProxy.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/23.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

@available(iOS 13.0, *)
final class RxNFCTagReaderSessionDelegateProxy: NSObject, NFCTagReaderSessionDelegate {
    
    let subject = PublishSubject<RxNFCTagReaderSessionEvent>()
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        subject.onNext(.didBecomeActive(session))
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        subject.onNext(.didError((session, error)))
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        subject.onNext(.didDetect((session, tags)))
    }
    
}
