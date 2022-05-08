//
//  Error + Notconnected.swift
//  Messages
//
//  Created by Denis on 07.05.2022.
//

import Foundation

extension Error {
    
    var isNotConnected: Bool {
        let nsError = self as NSError
        
        switch (nsError.domain, nsError.code) {
        case (NSURLErrorDomain, NSURLErrorCannotFindHost),
             (NSURLErrorDomain, NSURLErrorCannotConnectToHost),
             (NSURLErrorDomain, NSURLErrorNetworkConnectionLost),
             (NSURLErrorDomain, NSURLErrorDNSLookupFailed),
             (NSURLErrorDomain, NSURLErrorNotConnectedToInternet),
             (NSURLErrorDomain, NSURLErrorCallIsActive),
             (NSURLErrorDomain, NSURLErrorDataNotAllowed):
            return true
        default:
            return false
        }
    }
}
