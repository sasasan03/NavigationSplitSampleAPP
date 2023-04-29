//
//  UserDefaultManager.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/25.
//

import Foundation

class UserDefaultManager {
    private let userDefault = UserDefaults.standard
    private var key = "Trainer_key"
    
    func save(trainer: [PokemonTrainer]) throws {
        do {
            let json = try encode(trainer: trainer)
            userDefault.set(json, forKey: key)
        } catch {
            switch error as? DataConvertError ?? DataConvertError.unknown {
            case .encodingError:
                throw DataConvertError.encodingError
            case .dataCorrupted:
                throw DataConvertError.dataCorrupted
            default:
                throw DataConvertError.unknown
            }
        }
    }
    
    func load() throws -> [PokemonTrainer] {
        guard let json = userDefault.string(forKey: key) else {
            throw DataConvertError.dataGetError
        }
        do {
            let trainers = try decode(json: json)
            return trainers
        } catch {
            switch error as? DataConvertError ?? DataConvertError.unknown {
            case .decodingError:
                throw DataConvertError.decodingError
            case .dataCorrupted:
                throw DataConvertError.dataCorrupted
            default:
                throw DataConvertError.unknown
            }
        }
    }
    
    private func decode(json: String) throws -> [PokemonTrainer] {
        do {
            guard let data = json.data(using: .utf8) else {
                throw DataConvertError.decodingError
            }
            let trainers = try JSONDecoder().decode([PokemonTrainer].self, from: data)
            return trainers
        } catch {
            throw DataConvertError.decodingError
        }
    }
    
    private func encode(trainer: [PokemonTrainer]) throws -> String {
        do {
            let data = try JSONEncoder().encode(trainer)
            guard let json = String(data: data, encoding: .utf8) else {
                throw DataConvertError.dataCorrupted
            }
            return json
        } catch {
            throw DataConvertError.encodingError
        }
    }
}
