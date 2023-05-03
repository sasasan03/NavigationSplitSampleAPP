//
//  NonTextError.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/30.
//

import Foundation

enum NonTextError: Error {
    case nonTrainerText
    case nonPoekmonText
    case unKnownError
    
    var nonTextFieldType: String {
        switch self {
        case .nonTrainerText: return "トレーナーの名前を入力して"
        case .nonPoekmonText: return "ポケモンの名前を入力して"
        case .unKnownError: return "unKnowError"
        }
    }
}


