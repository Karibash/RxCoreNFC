//
//  RxNFCTagReaderSession+Rx.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/30.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

@available(iOS 13.0, *)
extension Observable where Element: RxNFCTagReaderSession {
    
    // MARK: - Tags -
    
    public func tags() ->Observable<NFCTag> {
        flatMap { $0.tags }
    }
    
}

@available(iOS 13.0, *)
extension Observable where Element: RxNFCTagReaderSession {
    
    // MARK: - Actions -
    
    public func begin() -> Observable<RxNFCTagReaderSession> {
        flatMap { $0.begin() }
    }
    
    public func invalidate() -> Observable<RxNFCTagReaderSession> {
        flatMap { $0.invalidate() }
    }
    
    public func restartPolling() -> Observable<RxNFCTagReaderSession> {
        flatMap { $0.restartPolling() }
    }
    
}

@available(iOS 13.0, *)
extension Observable where Element: RxNFCTagReaderSession {
    
    // MARK: - Connect -
    
    public func connect(_ tag: NFCTag) -> Observable<NFCTag> {
        flatMap { $0.connect(tag) }
    }
    
    public func connect(_ tag: NFCFeliCaTag) -> Observable<NFCFeliCaTag> {
        flatMap { $0.connect(tag) }
    }
    
    public func connect(_ tag: NFCISO7816Tag) -> Observable<NFCISO7816Tag> {
        flatMap { $0.connect(tag) }
    }
    
    public func connect(_ tag: NFCISO15693Tag) -> Observable<NFCISO15693Tag> {
        flatMap { $0.connect(tag) }
    }
    
    public func connect(_ tag: NFCMiFareTag) -> Observable<NFCMiFareTag> {
        flatMap { $0.connect(tag) }
    }
    
}
