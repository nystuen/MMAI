import Foundation
import Combine

class AthleteMatchupViewModel: ObservableObject {
    
    @Published var initialAthletePickerStep = 0
    @Published var athletePreviews: [AthlethePreview] = []
    @Published var athleteSearchTerm = ""
    @Published var athleteSearchCorner: AthleteType = .red
    
    @Published var athleteA: Athlete?
    @Published var athleteB: Athlete?
    @Published var comparisonTable: AthleteComparisonTable?
    
    @Published var isLoading: Bool = true
    
    @Published var isPredicting: Bool = false
    @Published var predictionResult: PredictionResult?
    
    var cancellables = Set<AnyCancellable>()
    
    private var athleteService: AthleteService = AthleteService()
    
    var match: UpcomingMatch?
    
    init() {
        setupSubscribers()
        athleteService.getAllAthletePreviews()
    }
    
    func setupSubscribers() {
        $athleteSearchTerm
            .sink { [weak self] searchTerm in
                guard let athleteType = self?.athleteSearchCorner else { return }
                self?.athleteService.getAthlete(name: searchTerm, athleteType: athleteType)
            }
            .store(in: &cancellables)
        
        athleteService.$athleteA
            .sink { [weak self] athleteA in
                self?.athleteA = athleteA
                if athleteA != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        self?.initialAthletePickerStep = 1
                    }
                }

            }
            .store(in: &cancellables)
        
        athleteService.$athleteB
            .sink { [weak self] athleteB in
                self?.athleteB = athleteB
            }
            .store(in: &cancellables)
        
        athleteService.$predictionResult
            .sink { [weak self] result in
                self?.predictionResult = result
                self?.isPredicting = false
            }
            .store(in: &cancellables)
        
        $athleteA
            .combineLatest($athleteB)
            .sink { [weak self] athleteA, athleteB in
                if let athleteA = athleteA, let athleteB = athleteB {
                    self?.setAthleteComparisonTable(athleteA: athleteA, athleteB: athleteB)
                }
            }
            .store(in: &cancellables)
        
        $comparisonTable
            .sink { [weak self] comparisonTable in
                self?.isLoading = comparisonTable == nil && self?.match != nil
                self?.predictionResult = nil
            }
            .store(in: &cancellables)
        
        
        $isPredicting
            .sink { [weak self] isPredicting in
                if let athleteA = self?.athleteA, let athleteB = self?.athleteB, isPredicting {
                    self?.athleteService.predictWinner(athleteA: athleteA, athleteB: athleteB)
                }
            }
            .store(in: &cancellables)
    }
    
    func onAppear(match: UpcomingMatch) {
        athleteService.getAthletes(nameA: match.redName, nameB: match.blueName)
    }
    
    func setAthleteComparisonTable(athleteA: Athlete, athleteB: Athlete) {
        let height = (athleteA.height + "/\(athleteA.heightCM.asCm())",
                      athleteB.height + "/\(athleteB.heightCM.asCm())")
        
        let weight = (athleteA.weight.asLbs() + "/" + athleteA.weightKg.asKg(),
                      athleteB.weight.asLbs() + "/" + athleteB.weightKg.asKg())
        
        let reach = (athleteA.reach.asInches() + "/" + athleteA.reachCM.asCm(),
                     athleteB.reach.asInches() + "/" + athleteB.reachCM.asCm())
        
        comparisonTable = AthleteComparisonTable(name: (athleteA.name, athleteB.name),
                                                 image: (athleteA.image, athleteB.image),
                                                 age: (athleteA.birth, athleteB.birth),
                                                 stance: (athleteA.stance, athleteB.stance),
                                                 weightClass: (athleteA.weightClass, athleteB.weightClass),
                                                 record: (athleteA.record, athleteB.record),
                                                 height: height,
                                                 dominantHeight: getDominantStat(athleteA.heightCM, athleteB.heightCM),
                                                 weight: weight,
                                                 dominantWeight: getDominantStat(athleteA.weight, athleteB.weight),
                                                 reach: reach,
                                                 dominantReach: getDominantStat(athleteA.reach, athleteB.reach),
                                                 takedownAccuracy: (athleteA.takedownAccuracy.asPercent(), athleteB.takedownAccuracy.asPercent()),
                                                 dominantTakedownAccuracy: getDominantStat(athleteA.takedownAccuracy, athleteB.takedownAccuracy),
                                                 atapm: (String(athleteA.takedownAverage), String(athleteB.takedownAverage)),
                                                 dominantAtapm: getDominantStat(athleteA.takedownAverage, athleteB.takedownAverage),
                                                 asapm: (String(athleteA.submissionAverage), String(athleteB.submissionAverage)),
                                                 dominantAsapm: getDominantStat(athleteA.submissionAverage, athleteB.submissionAverage),
                                                 strikingAccuracy: (athleteA.strikesAccuracy.asPercent(), athleteB.strikesAccuracy.asPercent()),
                                                 dominantStrikingAccuracy: getDominantStat(athleteA.strikesAccuracy, athleteB.strikesAccuracy),
                                                 sigStrikesLpm: (athleteA.slpm, athleteB.slpm),
                                                 sigStrikesApm: (athleteA.sapm, athleteB.sapm),
                                                 takedownDeference: (athleteA.takedownDefence, athleteB.takedownDefence),
                                                 strikesDeference: (athleteA.strikesDefence, athleteB.strikesDefence))
    }
    
    func getDominantStat(_ statA: Any?, _ statB: Any?) -> AthleteType? {
        if let statA = statA as? Double, let statB = statB as? Double {
            if statA > statB {
                return .red
            } else if statB > statA {
                return .blue
            }
        } else if let statA = statA as? Int, let statB = statB as? Int {
            if statA > statB {
                return .red
            } else if statB > statA {
                return .blue
            }
        }
        return nil
    }
}

struct AthleteComparisonTable: Equatable {
    let name: (String, String)
    let image: (String, String)
    let age: (String, String)
    let stance: (String, String)
    let weightClass: (String, String)
    let record: (String, String)
    
    let height: (String, String)
    let dominantHeight: AthleteType?
    
    let weight: (String, String)
    let dominantWeight: AthleteType?
    
    let reach: (String, String)
    let dominantReach: AthleteType?
    
    let takedownAccuracy: (String, String)
    let dominantTakedownAccuracy: AthleteType?
    
    let atapm: (String, String) // Average takedown attempts per match
    let dominantAtapm: AthleteType?
    
    let asapm: (String, String) // Average submission attempts per match
    let dominantAsapm: AthleteType?
    
    let strikingAccuracy: (String, String)
    let dominantStrikingAccuracy: AthleteType?
    
    let sigStrikesLpm: (Double, Double) // Average significant strikes landed per minute
    let sigStrikesApm: (Double, Double) // Average significant strikes absorbed per minute
    
    let takedownDeference: (Int, Int) // Average takedown defence in %
    let strikesDeference: (Double, Double) // Average strikes defence in %
    
    static func == (lhs: AthleteComparisonTable, rhs: AthleteComparisonTable) -> Bool {
        lhs.name == rhs.name
    }
}
