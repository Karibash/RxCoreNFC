//
//  RxNFCFeliCaRequestServiceV2Result.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/07/17.
//  Copyright © 2020 Karibash. All rights reserved.
//

import Foundation
import CoreNFC

@available(iOS 13.0, *)
public struct RxNFCFeliCaRequestServiceV2Result {
    public let statusFlag: RxNFCFeliCaStatusFlag
    public let encryptionIdentifier: EncryptionId
    public let nodeKeyVersionListAES: [Data]
    public let nodeKeyVersionListDES: [Data]
}
