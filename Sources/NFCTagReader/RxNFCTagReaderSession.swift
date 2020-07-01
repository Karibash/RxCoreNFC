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

@available(iOS 13.0, *)
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

@available(iOS 13.0, *)
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

@available(iOS 13.0, *)
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

@available(iOS 13.0, *)
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

@available(iOS 13.0, *)
extension RxNFCTagReaderSession {
    
    // MARK: - Connect -
    
    public func connect(_ tag: NFCTag) -> Single<NFCTag> {
        Single.create { observer in
            self.session.connect(to: tag, completionHandler: { error in
                if error != nil {
                    observer(.error(error!))
                } else {
                    observer(.success(tag))
                }
            })
            return Disposables.create()
        }
    }
    
    public func connect(_ tag: NFCFeliCaTag) -> Single<NFCFeliCaTag> {
        Single.create { observer in
            self.session.connect(to: .feliCa(tag), completionHandler: { error in
                if error != nil {
                    observer(.error(error!))
                } else {
                    observer(.success(tag))
                }
            })
            return Disposables.create()
        }
    }
    
    public func connect(_ tag: NFCISO7816Tag) -> Single<NFCISO7816Tag> {
        Single.create { observer in
            self.session.connect(to: .iso7816(tag), completionHandler: { error in
                if error != nil {
                    observer(.error(error!))
                } else {
                    observer(.success(tag))
                }
            })
            return Disposables.create()
        }
    }
    
    public func connect(_ tag: NFCISO15693Tag) -> Single<NFCISO15693Tag> {
        Single.create { observer in
            self.session.connect(to: .iso15693(tag), completionHandler: { error in
                if error != nil {
                    observer(.error(error!))
                } else {
                    observer(.success(tag))
                }
            })
            return Disposables.create()
        }
    }

    public func connect(_ tag: NFCMiFareTag) -> Single<NFCMiFareTag> {
        Single.create { observer in
            self.session.connect(to: .miFare(tag), completionHandler: { error in
                if error != nil {
                    observer(.error(error!))
                } else {
                    observer(.success(tag))
                }
            })
            return Disposables.create()
        }
    }
    
}
