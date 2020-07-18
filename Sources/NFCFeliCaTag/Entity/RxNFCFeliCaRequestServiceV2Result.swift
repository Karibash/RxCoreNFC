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
    let statusFlag: RxNFCFeliCaStatusFlag
    let encryptionIdentifier: EncryptionId
    let nodeKeyVersionListAES: [Data]
    let nodeKeyVersionListDES: [Data]
}
