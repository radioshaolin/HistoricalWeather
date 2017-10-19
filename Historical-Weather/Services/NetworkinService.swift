//
//  NetworkinService.swift
//  Incode-Test-Task
//
//  Created by Radio Shaolin on 19.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation


// MARK: - API
/**
 Fake API responsible for reprsesenting URL with data
 */
struct API {
    static let meteoDataRequestURL: String = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt"
    static let testURL: String = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/whitbydata.txt"
}

// MARK: - NetworkingService
/**
 Singleton class responsible for async fetching data with given url
 */
class NetworkingService {
    
    static let instance = NetworkingService()
    private init() {}
    //MARK: - Function responsible for async downloading data
    func downloadData(withURL url: String, withCompletion completion: @escaping ([[String]]) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            let session = URLSession(configuration: .ephemeral)
            let url = URL(string: url)!
            let task = session.dataTask(with: url) { (data, response, error) -> Void in
                guard let data = data else { return }
                guard let textData = String(data: data, encoding: String.Encoding.utf8) else { return }
                do {
                    let parsedTextData = try Parser.parse(textData: textData)
    //                print(parsedTextData)
                    DispatchQueue.main.async { completion(parsedTextData) }
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
        }

    }
}
