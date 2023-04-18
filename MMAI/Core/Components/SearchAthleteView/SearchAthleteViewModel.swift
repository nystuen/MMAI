import Combine

class SearchAthleteViewModel: ObservableObject {
    @Published var filteredAthletes: [AthlethePreview] = []
    
    var cancellables = Set<AnyCancellable>()
    
    private var athleteService: AthleteService = AthleteService()
    private var athletePreviews: [AthlethePreview] = []
    
    func searchOnChange(searchTerm: String) {
        if !searchTerm.isEmpty {
            filteredAthletes = athletePreviews
                .filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
        } else {
            filteredAthletes = athletePreviews
        }
    }
    
    init() {
        athleteService.getAllAthletePreviews()
        
        athleteService.$athletePreviews
            .sink { [weak self] previews in
                self?.athletePreviews = previews.filter { self?.athleteHasImage($0.image) ?? true }
                self?.filteredAthletes = previews.filter { self?.athleteHasImage($0.image) ?? true }
            }
            .store(in: &cancellables)
    }
    
    private func athleteHasImage(_ url: String) -> Bool {
        !url.contains("imgur")
    }
}
