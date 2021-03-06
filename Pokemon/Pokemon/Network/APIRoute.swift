import Foundation

/// Enum that encodes the endpoints of the poke-api, required for the assignment. Can be fed into the RequestHandler.
///
/// It makes sure you don't have to worry too much about writing down the requests, and instead focus on the request manager.
/// In the RequestManager, simply use `APIRoute.asRequest()` to get the URLRequest to perform.
enum APIRoute {
    case getPokemonsList(limit: Int, offset: Int)
    case getPokemonDetails(URL)
    case getEvolutionChain(URL)
    case getImage(Int)

    private var baseURLString: String { "https://pokeapi.co/api/v2/" }
    private var baseImageURLString: String { "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" }

    private var url: URL? {
        switch self {
        case .getPokemonDetails(let url),
            .getEvolutionChain(let url):
            return url
            
        case .getImage(let id):
            let baseURL = "\(baseImageURLString)" + "\(id).png"
            return URL(string: baseURL)
            
        case .getPokemonsList:
            return URL(string: baseURLString + "pokemon-species")
        }
    }

    private var parameters: [URLQueryItem] {
        switch self {
        case .getPokemonsList(let limit, let offset):
            return [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "offset", value: String(offset))
            ]
        default:
            return []
        }
    }
    
    func asURL() -> URL{
        guard let url = url else {
            preconditionFailure("Missing URL for route: \(self)")
        }
        return url
    }

    func asRequest() -> URLRequest {
        guard let url = url else {
            preconditionFailure("Missing URL for route: \(self)")
        }
        if !parameters.isEmpty{
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = parameters

            guard let parametrizedURL = components?.url else {
                preconditionFailure("Missing URL with parameters for url: \(url)")
            }
            return URLRequest(url: parametrizedURL)
        }
        
        return URLRequest(url: url)
        
    }
}
