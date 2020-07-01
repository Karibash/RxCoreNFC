//
//  RxNFCReaderError.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/26.
//  Copyright © 2020 Karibash. All rights reserved.
//

struct RxNFCReaderError: LocalizedError {

   private var description: String

   var errorDescription: String? {
       return description
   }
    
}

@available(iOS 13.0, *)
extension RxNFCReaderError {

   static let readerSessionRetrieveError = RxNFCReaderError(description: "Failed to retrieve the session")
    
}
