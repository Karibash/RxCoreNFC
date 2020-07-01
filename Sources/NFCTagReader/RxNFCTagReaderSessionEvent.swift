//
//  RxNFCTagReaderSessionEvent.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/23.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC

@available(iOS 13.0, *)
public typealias RxNFCDidBecomeActiveEvent = (NFCTagReaderSession)

@available(iOS 13.0, *)
public typealias RxNFCDidErrorEvent = (session: NFCTagReaderSession, error: Error)

@available(iOS 13.0, *)
public typealias RxNFCDidDetectEvent = (session: NFCTagReaderSession, tags: [NFCTag])

@available(iOS 13.0, *)
public enum RxNFCTagReaderSessionEvent {
    case didBecomeActive(RxNFCDidBecomeActiveEvent)
    case didError(RxNFCDidErrorEvent)
    case didDetect(RxNFCDidDetectEvent)
}
