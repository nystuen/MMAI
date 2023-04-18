import Foundation
import Apollo
import Combine

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: "url")!)
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unkown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
            case .unkown: return "[⚠️] Unknown error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap{ try handleURLResponse(output: $0, url: url) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func fetchUpcomingEvents(completion: @escaping ([SchemaAPI.UpcomingEventsQuery.Data.UpcomingEvent]) -> Void){
        apollo.fetch(query: SchemaAPI.UpcomingEventsQuery()) { result in
            switch result {
            case .success(let result):
                if let events = result.data {
                    completion(events.upcomingEvents)
                }
            case .failure(let error):
                print("ERROR: \(error)")
            }
         }
    }
    
    func fetchCompletedEvents(completion: @escaping ([SchemaAPI.CompletedEventsQuery.Data.CompletedEvent]) -> Void){
        apollo.fetch(query: SchemaAPI.CompletedEventsQuery()) { result in
            switch result {
            case .success(let result):
                if let events = result.data {
                    completion(events.completedEvents)
                }
            case .failure(let error):
                print("ERROR: \(error)")
            }
         }
    }
    
    func fetchOneCompletedEvent(eventName: String, date: String, completion: @escaping ([SchemaAPI.OneCompletedEventQuery.Data.OneCompletedEvent]) -> Void) {
        apollo.fetch(query: SchemaAPI.OneCompletedEventQuery(eventName: eventName, date: date)) { result in
            switch result {
            case .success(let result):
                if let data = result.data {
                    completion(data.oneCompletedEvent)
                }
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func fetchAthleteInformation(name: String, completion: @escaping (Result<SchemaAPI.OneFighterQuery.Data.OneFighter, Error>) -> Void) {
        apollo.fetch(query: SchemaAPI.OneFighterQuery(name: name)) { result in
            switch result {
            case .success(let result):
                if let data = result.data {
                    completion(.success(data.oneFighter))
                }
            case .failure(let error):
                completion(.failure(error))
                print("ERROR: \(error)")
            }
        }
    }

    func fetchAllAthletes(completion: @escaping ([SchemaAPI.AllFightersQuery.Data.AllFighter]) -> Void) {
        apollo.fetch(query: SchemaAPI.AllFightersQuery()) { result in
            switch result {
            case .success(let result):
                if let data = result.data {
                    completion(data.allFighters)
                }
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func predictWinner(athleteA: Athlete, athleteB: Athlete, completion: @escaping (Result<SchemaAPI.PredictWinnerQuery.Data.PredictedWinner, Error>) -> Void) {
        let startTime = Date.now
        
        apollo.fetch(query: SchemaAPI.PredictWinnerQuery(redName: athleteA.name, blueName: athleteB.name)) { result in
            let timeDifference = Date.now.timeIntervalSince(startTime)
            switch result {
            case .success(let result):
                if let data = result.data {
                    DispatchQueue.main.asyncAfter(deadline: .now() + (1.5 - timeDifference)) {
                        completion(.success(data.predictedWinner))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
                print("ERROR: \(error)")
            }
        }
    }
}
