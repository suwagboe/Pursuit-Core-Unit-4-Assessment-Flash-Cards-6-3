//
//  CardsAPIClient.swift
//  Unit4Assessment
//
//  Created by Pursuit on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import NetworkHelper

struct CardsAPIClient{
    
    static func getTheCardInfo(completion: @escaping (Result<[CardData],AppError>) -> ()){
        // only needs completion because the url is the direct link to the infomation no extra filter necessay..

        let endpointURL = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
        
        
               guard let url = URL(string: endpointURL) else {
                   completion(.failure(.badURL(endpointURL)))
                   return
               }
               
               let request = URLRequest(url: url)
               
               NetworkHelper.shared.performDataTask(with: request) { (result) in
                   switch result{
                   case .failure(let appError):
                       // this is where the decoding of the data should happen and return the data
                       completion(.failure(.decodingError(appError)))
                   case .success(let data):
                       do{
                           // MARK: remember to ALWAYS go from the top level and then go deeper inside of the model
                           let cardsInfo = try JSONDecoder().decode(Cards.self, from: data)
                        completion(.success(cardsInfo.cards))
                       }catch{
                           completion(.failure(.decodingError(error)))
                       }
                       
                   }
               }
        
    }
}
