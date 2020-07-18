//
//  RxNFCFelicaRequestSpecificationVersionResult.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/07/17.
//  Copyright © 2020 Karibash. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
public struct RxNFCFelicaRequestSpecificationVersionResult {
    let statusFlag: RxNFCFeliCaStatusFlag
    let basicVersion: Data
    let optionVersion: Data
}
