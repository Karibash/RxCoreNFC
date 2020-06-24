//
//  RxNFCTagReaderSessionEvent.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/23.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC

public typealias RxNFCDidBecomeActiveEvent = (NFCTagReaderSession)
public typealias RxNFCDidErrorEvent = (session: NFCTagReaderSession, error: Error)
public typealias RxNFCDidDetectEvent = (session: NFCTagReaderSession, tags: [NFCTag])

public enum RxNFCTagReaderSessionEvent {
    case didBecomeActive(RxNFCDidBecomeActiveEvent)
    case didError(RxNFCDidErrorEvent)
    case didDetect(RxNFCDidDetectEvent)
}
