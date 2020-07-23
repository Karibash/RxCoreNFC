//
//  RxNFCISO7816SendCommandResult.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/07/22.
//  Copyright © 2020 Karibash. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
public struct RxNFCISO7816SendCommandResult {
    public let data: Data
    public let sw1: UInt8
    public let sw2: UInt8
}
