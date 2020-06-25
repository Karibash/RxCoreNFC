//
//  RxNFCTagReaderSession.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/23.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift
import RxCocoa

public final class RxNFCTagReaderSession {
    
    // MARK: - Private properties -
    
    private let delegate: Observable<RxNFCTagReaderSessionEvent>
    
    private let session: NFCTagReaderSession
    
    // MARK: - Constructor -
    
    public init(pollingOption: NFCTagReaderSession.PollingOption) {
        let proxy = RxNFCTagReaderSessionDelegateProxy()
        delegate = proxy.subject.asObservable()
        session = NFCTagReaderSession(pollingOption: pollingOption, delegate: proxy)!
    }
    
}

// MARK: - Extensions -

extension RxNFCTagReaderSession {
    
    // MARK: - Events -
    
    public var events: ControlEvent<RxNFCTagReaderSessionEvent> {
        return ControlEvent(events: delegate)
    }
    
    public var didBecomeActiveEvents: ControlEvent<RxNFCDidBecomeActiveEvent> {
        let events = delegate.flatMap { (event) -> Observable<RxNFCDidBecomeActiveEvent> in
            guard case let .didBecomeActive(event) = event else {
                return Observable.empty()
            }
            return Observable.of(event)
        }
        return ControlEvent(events: events)
    }
    
    public var didErrorEvents: ControlEvent<RxNFCDidErrorEvent> {
        let events = delegate.flatMap { (event) -> Observable<RxNFCDidErrorEvent> in
            guard case let .didError(event) = event else {
                return Observable.empty()
            }
            return Observable.of(event)
        }
        return ControlEvent(events: events)
    }
    
    public var didDetectTagEvents: ControlEvent<RxNFCDidDetectEvent> {
        let events = delegate.flatMap { (event) -> Observable<RxNFCDidDetectEvent> in
            guard case let .didDetect(event) = event else {
                return Observable.empty()
            }
            return Observable.of(event)
        }
        return ControlEvent(events: events)
    }
    
}

extension RxNFCTagReaderSession {
    
    // MARK: - Tags -
    
    public var nfcTags: Observable<NFCTag> {
        delegate.flatMap { (event) -> Observable<NFCTag> in
            guard case let .didDetect(event) = event else {
                return Observable.empty()
            }
            return Observable.create { observer in
                event.tags.forEach { observer.onNext($0) }
                return Disposables.create()
            }
        }
    }
    
    public var felicaTags: Observable<NFCFeliCaTag> {
        nfcTags.flatMap { (tag) -> Observable<NFCFeliCaTag> in
            guard case let .feliCa(tag) = tag else {
                return Observable.empty()
            }
            return Observable.of(tag)
        }
    }
    
    public var iso7816Tags: Observable<NFCISO7816Tag> {
        nfcTags.flatMap { (tag) -> Observable<NFCISO7816Tag> in
            guard case let .iso7816(tag) = tag else {
                return Observable.empty()
            }
            return Observable.of(tag)
        }
    }
    
    public var iso15693Tags: Observable<NFCISO15693Tag> {
        nfcTags.flatMap { (tag) -> Observable<NFCISO15693Tag> in
            guard case let .iso15693(tag) = tag else {
                return Observable.empty()
            }
            return Observable.of(tag)
        }
    }
    
    public var miFareTags: Observable<NFCMiFareTag> {
        nfcTags.flatMap { (tag) -> Observable<NFCMiFareTag> in
            guard case let .miFare(tag) = tag else {
                return Observable.empty()
            }
            return Observable.of(tag)
        }
    }
    
}

extension RxNFCTagReaderSession {
    
    // MARK: - Triggers -
    
    public var begin: AnyObserver<Void> {
        AnyObserver<Void> { [unowned self] event in
            guard case .next(_) = event else { return }
            self.session.begin()
        }
    }
    
    public var invalidate: AnyObserver<Void> {
        AnyObserver<Void> { [unowned self] event in
            guard case .next(_) = event else { return }
            self.session.invalidate()
        }
    }
    
    public var restartPolling: AnyObserver<Void> {
        AnyObserver<Void> { [unowned self] event in
            guard case .next(_) = event else { return }
            self.session.restartPolling()
        }
    }
    
}
