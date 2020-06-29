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
    
    public var tags: Observable<NFCTag> {
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
    
}

extension RxNFCTagReaderSession {
    
    // MARK: - Triggers -
    
    public var begin: Single<RxNFCTagReaderSession> {
        Single.create { observer in
            self.session.begin()
            observer(.success(self))
            return Disposables.create()
        }
    }
    
    public var invalidate: Single<RxNFCTagReaderSession> {
        Single.create { observer in
            self.session.invalidate()
            observer(.success(self))
            return Disposables.create()
        }
    }
    
    public var restartPolling: Single<RxNFCTagReaderSession> {
        Single.create { observer in
            self.session.restartPolling()
            observer(.success(self))
            return Disposables.create()
        }
    }
    
}
