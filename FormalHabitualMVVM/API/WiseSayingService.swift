//
//  WiseSayingService.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2022/01/23.
//

import Foundation

enum NetworkingError: Error {
    case badUrl, noData, decodingError
}

class WiseSayingService {

    func getWiseSayingInfo(completion: @escaping(Result<WiseSayingResponse, NetworkingError>) -> Void) {

        let urlString = URL(string: "https://gist.githubusercontent.com/nasrulhazim/54b659e43b1035215cd0ba1d4577ee80/raw/e3c6895ce42069f0ee7e991229064f167fe8ccdc/quotes.json")

        guard let url = urlString else {
            print("url 없음")
            return completion(.failure(.badUrl))
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let wiseSayingResponse = try? JSONDecoder().decode(WiseSayingResponse.self, from: data)
            if let wiseSayingResponse = wiseSayingResponse {
//                print("wiseSayingResponse 값: \(wiseSayingResponse)")
                completion(.success(wiseSayingResponse))
            } else {
                print("Decoding error")
                
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
