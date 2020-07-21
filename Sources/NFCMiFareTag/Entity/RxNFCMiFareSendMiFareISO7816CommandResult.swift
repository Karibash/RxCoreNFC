//
//  RxNFCMiFareSendMiFareISO7816CommandResult.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/07/21.
//  Copyright © 2020 Karibash. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
public struct RxNFCMiFareSendMiFareISO7816CommandResult {
    let data: Data
    let sw1: UInt8
    let sw2: UInt8
}
