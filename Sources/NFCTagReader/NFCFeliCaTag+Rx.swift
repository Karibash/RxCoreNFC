//
//  NFCFeliCaTag+Rx.swift
//  RxCoreNFC
//
//  Created by Karibash on 2020/06/26.
//  Copyright © 2020 Karibash. All rights reserved.
//

import CoreNFC
import RxSwift

extension ObservableType where Element == NFCFeliCaTag {
    
    public var connect: Observable<Element> {
        flatMap { tag in
            return Single<Element>.create { observer in
                guard let session = tag.session as? NFCTagReaderSession else {
                    observer(.error(RxNFCReaderError.readerSessionRetrieveError))
                    return Disposables.create()
                }
                session.connect(
                    to: .feliCa(tag),
                    completionHandler: { _ in observer(.success(tag)) }
                )
                return Disposables.create()
            }
        }
    }
    
}
