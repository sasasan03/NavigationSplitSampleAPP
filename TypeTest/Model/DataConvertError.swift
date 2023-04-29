//
//  DataConvertError.swift
//  kai1110-kadai19-SwiftUI
//
//  Created by 渡邊魁優 on 2023/04/07.
//

import Foundation

enum DataConvertError: Error {
    case encodingError
    case decodingError
    case dataGetError
    case dataCorrupted
    case unknown
    
    var title: String {
        switch self {
        case .encodingError:
            return "エンコードエラー"
        case .decodingError:
            return "デコードエラー"
        case .dataGetError:
            return "データ取得失敗"
        case .dataCorrupted:
            return "データが破損"
        default:
            return "不明なエラー"
        }
    }
}
