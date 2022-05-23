import Foundation

enum RequestError: Error{
    case NetworkError(description:String)
    case ParsingError
    case NoData
    
    var description:String{
        switch self {
        case .NetworkError(let description):
            return description
        case .ParsingError:
            return "Error while parsing json to data model"
        case .NoData:
            return "No Data is returned from request"
        }
    }
    
}


/// This is RequestHandling implementation returns a hardcoded list of Species.
///
/// This is to be replaced by a proper implementation that actually makes the network call given the APIRoute, parses the response, and returns the resulting object.
class RequestHandler: RequestHandling {
 
    func request<T>(route: APIRoute, completion: @escaping (Result<T, Error>) -> Void)  where T:Codable{
        let request = route.asRequest()
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            // Request Error
            if let e = error{
                completion(.failure(RequestError.NetworkError(description: e.localizedDescription)))
            }
            // check if data is not empty
            if let data = data{
                // Try Parsing data
                if let responseResults = self.parse(data: data, to: T.self) {
                    completion(.success(responseResults))
                }else{
                    // Parsing Error
                    completion(.failure(RequestError.ParsingError))
                }
            }else{
                // No Data Error
                completion(.failure(RequestError.NoData))
            }
        })

        task.resume()
    }
    
    private func parse<T>(data:Data , to type: T.Type) ->T? where T:Codable{
        do{
            let dataObject = try JSONDecoder().decode(type, from: data)
            return dataObject
        }
        catch{
            print(error.localizedDescription)
        }
        return nil
    }
}

