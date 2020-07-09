//
//  NFCTag+Rx.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/27.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

@available(iOS 13.0, *)
extension ObservableType where Element == NFCTag {

    // MARK: - Filters -
    
    public func felicaTags() -> Observable<NFCFeliCaTag> {
        flatMap { (tag) -> Observable<NFCFeliCaTag> in
            guard case let .feliCa(tag) = tag else {
                return Observable.empty()
            }
            return Observable.of(tag)
        }
    }
    
    public func iso7816Tags() -> Observable<NFCISO7816Tag> {
        flatMap { (tag) -> Observable<NFCISO7816Tag> in
            guard case let .iso7816(tag) = tag else {
                return Observable.empty()
            }
            return Observable.of(tag)
        }
    }
    
    public func iso15693Tags() -> Observable<NFCISO15693Tag> {
        flatMap { (tag) -> Observable<NFCISO15693Tag> in
            guard case let .iso15693(tag) = tag else {
                return Observable.empty()
            }
            return Observable.of(tag)
        }
    }
    
    public func miFareTags() -> Observable<NFCMiFareTag> {
        flatMap { (tag) -> Observable<NFCMiFareTag> in
            guard case let .miFare(tag) = tag else {
                return Observable.empty()
            }
            return Observable.of(tag)
        }
    }
    
}
