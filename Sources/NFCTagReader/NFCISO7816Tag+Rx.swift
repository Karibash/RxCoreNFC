//
//  NFCISO7816Tag+Rx.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/26.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

extension ObservableType where Element == NFCISO7816Tag {
    
    public var connect: Observable<Element> {
        flatMap { tag in
            return Single<Element>.create { observer in
                guard let session = tag.session as? NFCTagReaderSession else {
                    observer(.error(RxNFCReaderError.readerSessionRetrieveError))
                    return Disposables.create()
                }
                session.connect(
                    to: .iso7816(tag),
                    completionHandler: { _ in observer(.success(tag)) }
                )
                return Disposables.create()
            }
        }
    }
    
}
