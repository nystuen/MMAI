import Foundation
import Combine

class AthleteViewModel: ObservableObject {
    @Published var athletePreviews: [AthlethePreview] = []
    @Published var athleteSearchTerm = ""
    @Published var athlete: Athlete?
    @Published var statsTable: AthleteStatsTable?
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    private var athleteService: AthleteService = AthleteService()
    
    init() {
        athleteService.getAllAthletePreviews()

        $athleteSearchTerm
            .sink { [weak self] searchTerm in
                self?.athleteService.getAthlete(name: searchTerm)
                
            }
            .store(in: &cancellables)
        
        athleteService.$athleteA
            .sink { [weak self] athlete in
                self?.athlete = athlete
            }
            .store(in: &cancellables)
        
        $athlete
            .sink { [weak self] athlete in
                if let athlete = athlete {
                    self?.setAthleteStatsTable(athlete: athlete)
                }
            }
            .store(in: &cancellables)
        
        $statsTable
            .sink { [weak self] statsTable in
                self?.isLoading = (self?.athlete != nil && statsTable == nil)
            }
            .store(in: &cancellables)
    }
    
    func searchForAthlete(name: String) {
        self.isLoading = true
        self.athleteSearchTerm = name
    }
    
    func setAthleteStatsTable(athlete: Athlete) {
        let height = athlete.height + "/\(athlete.heightCM.asCm())"
        let weight = athlete.weight.asLbs() + "/" + athlete.weightKg.asKg()
        let reach = athlete.reach.asInches() + "/" + athlete.reachCM.asCm()
        
        statsTable = AthleteStatsTable(name: athlete.name,
                                       image: athlete.image,
                                       age: athlete.birth,
                                       weightClass: athlete.weightClass,
                                       record: athlete.record,
                                       height: height,
                                       weight: weight,
                                       reach: reach,
                                       takedownAccuracy: athlete.takedownAccuracy.asPercent(),
                                       atapm: String(athlete.takedownAverage),
                                       asapm: String(athlete.submissionAverage),
                                       strikingAccuracy: athlete.strikesAccuracy.asPercent(),
                                       sigStrikesLpm: athlete.slpm,
                                       sigStrikesApm: athlete.sapm,
                                       takedownDeference: athlete.takedownDefence,
                                       strikesDeference: athlete.strikesDefence)
    }
}

struct AthleteStatsTable: Equatable {
    let name: String
    let image: String
    let age: String
    let weightClass: String
    let record: String
    let height: String
    let weight: String
    let reach: String
    let takedownAccuracy: String
    let atapm: String // Average takedown attempts per match
    let asapm: String // Average submission attempts per match
    let strikingAccuracy: String
    let sigStrikesLpm: Double // Average significant strikes landed per minute
    let sigStrikesApm: Double // Average significant strikes absorbed per minute
    let takedownDeference: Int // Average takedown defence in %
    let strikesDeference: Double // Average strikes defence in %
    
    static func == (lhs: AthleteStatsTable, rhs: AthleteStatsTable) -> Bool {
        lhs.name == rhs.name
    }
}
