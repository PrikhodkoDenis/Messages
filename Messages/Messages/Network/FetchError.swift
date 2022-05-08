//
//  FetchError.swift
//  Messages
//
//  Created by Denis on 07.05.2022.
//

import Foundation

enum FetchError: Error {
    case other
    case parse
    case isNotConnected
    
    var message: String {
        switch self {
        case .other:
            return "Что-то пошло не так"
        case .parse:
            return "Получены некорректные данные"
        case .isNotConnected:
            return "Нет соединения с интернетом"
        }
    }
}
