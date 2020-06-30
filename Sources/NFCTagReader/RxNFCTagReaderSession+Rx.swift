//
//  RxNFCTagReaderSession+Rx.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/30.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

extension Observable where Element: RxNFCTagReaderSession {
    
    // MARK: - Tags -
    
    public var tags: Observable<NFCTag> {
        flatMap { $0.tags }
    }
    
}

extension Observable where Element: RxNFCTagReaderSession {
    
    // MARK: - Triggers -
    
    public var begin: Observable<RxNFCTagReaderSession> {
        flatMap { $0.begin }
    }
    
    public var invalidate: Observable<RxNFCTagReaderSession> {
        flatMap { $0.invalidate }
    }
    
    public var restartPolling: Observable<RxNFCTagReaderSession> {
        flatMap { $0.restartPolling }
    }
    
}

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
