//
//  Bundle-Decodable.swift
//  UltimatePortfolio
//
//  Created by Ashish Dutt on 27/07/23.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(
        _ file: String,
        as type: T.Type = T.self,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) -> T{
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Failed to locate \(file) in the Bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Failed to locate \(file) in the Bundle")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        do{
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context){
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key) - \(context.debugDescription)'")
        } catch DecodingError.typeMismatch(_, let context){
            fatalError("Failed to decode \(file) from bundle due to type mismatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context){
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_){
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
        } catch{
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
