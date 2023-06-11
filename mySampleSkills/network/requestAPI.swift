//
//  requestAPI.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 11/06/23.
//

import Foundation

final class RequestAPI {
    enum endpoint: String {
        case url = "https://api.github.com/users"
        case mock = "userMock"
    }

    func fetchFromMock(completionHandler: @escaping ([UserResponse]) -> Void) {
        if let path = Bundle.main.path(forResource: endpoint.mock.rawValue, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

                if let response =  try? JSONDecoder().decode([UserResponse].self, from: data) {
                    completionHandler(response)
                }
            } catch {
                // handle error (its a mock)
            }
        }
    }

    func fetch(completionHandler: @escaping ([UserResponse]) -> Void) {
        if let url = URL(string: endpoint.url.rawValue) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Erro ao obter lista: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Erro na resposta. Código de status esperado: \(String(describing: response))")
                    return
                }
                
                if let checkData = data,
                   let response = try? JSONDecoder().decode([UserResponse].self, from: checkData) {
                    completionHandler(response)
                }
            })
            task.resume()
        }
    }
}
