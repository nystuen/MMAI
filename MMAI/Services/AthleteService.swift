import Foundation
import Combine

class AthleteService {
    
    @Published var athleteA: Athlete?
    @Published var athleteAError: Error?
    @Published var athleteB: Athlete?
    @Published var athleteBError: Error?
    @Published var athletePreviews: [AthlethePreview] = []
    @Published var predictionResult: PredictionResult?
    
    func getAthlete(name: String, athleteType: AthleteType = .red) {
        guard !name.isEmpty else { return }
        NetworkingManager.shared.fetchAthleteInformation(name: name) { [weak self] athlete in
            switch athlete {
            case .success(let athleteResult):
                if athleteType == . red {
                    self?.athleteA = Athlete.process(queryData: athleteResult)
                } else {
                    self?.athleteB = Athlete.process(queryData: athleteResult)
                }
            case .failure(let error):
                self?.athleteAError = error
            }
        }
    }
    
    func getAthletes(nameA: String, nameB: String) {
        if !nameA.isEmpty {
            NetworkingManager.shared.fetchAthleteInformation(name: nameA) { [weak self] athlete in
                switch athlete {
                case .success(let athleteResult):
                    self?.athleteA = Athlete.process(queryData: athleteResult)
                case .failure(let error):
                    self?.athleteAError = error
                }
            }
        }
        if !nameB.isEmpty {
            NetworkingManager.shared.fetchAthleteInformation(name: nameB) { [weak self] athlete in
                switch athlete {
                case .success(let athleteResult):
                    self?.athleteB = Athlete.process(queryData: athleteResult)
                case .failure(let error):
                    self?.athleteBError = error
                }
            }
        }
    }
    
    func getAllAthletePreviews() {
        NetworkingManager.shared.fetchAllAthletes { [weak self] athlethes in
            self?.athletePreviews = athlethes.compactMap { AthlethePreview.process(queryData: $0) }
        }
    }
    
    func predictWinner(athleteA: Athlete, athleteB: Athlete) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.predictionResult = .success(PredictionData(name: athleteA.name, prob: Double.random(in: 59.0..<72.0)))
        }
        
        
       /*
        NetworkingManager.shared.predictWinner(athleteA: athleteA, athleteB: athleteB) { [weak self] result in
           self?.predictionResult = PredictionResult.process(queryData: result)
        }
        */
         
    }
}
