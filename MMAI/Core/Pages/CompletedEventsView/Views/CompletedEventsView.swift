import SwiftUI

struct CompletedEventsView: View {
    @StateObject private var pickerVm = EventPickerViewModel<CompletedEvent>(eventService: RemoteEventService<CompletedEvent>())
    @State var showResults: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                if let event = pickerVm.selectedEvent {
                    ScrollView {
                        VStack(alignment: .center, spacing: 4) {
                            
                            EventPickerView<CompletedEvent>()
                                .environmentObject(pickerVm)
                            
                            VStack {
                                Text("Unknown location")
                                Text(event.date)
                            }
                            .foregroundColor(.theme.secondaryText)
                            .fontWeight(.medium)
                            .font(.headline)
                            
                            HStack {
                                Text("Red corner")
                                    .foregroundColor(.theme.red)
                                Spacer()
                                Text("Blue corner")
                                    .foregroundColor(.theme.blue)
                            }
                            .font(.headline)
                            .padding(.horizontal)
                            
                            matchesListView(matches: event.matches)
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 4)
                        .ignoresSafeArea(edges: .bottom)
                    }
                } else {
                    ProgressView()
                }
            }
        }
    }
}

struct CompletedEventsView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedEventsView()
    }
}

extension CompletedEventsView {
    private func matchesListView(matches: [CompletedMatch]) -> some View {
        return LazyVStack {
            ForEach(matches) { match in
                NavigationLink {
                    //AthleteMatchupView(match: match).toolbar(.hidden, for: .tabBar)
                    Text("\(match.redName) vs \(match.blueName)")
                } label: {
                    matchHistoryRow(match: match)
                }
                
            }
            .listRowBackground(Color.theme.background)
        }
        .listStyle(.plain)
        .buttonStyle(.plain)
        .scrollContentBackground(.hidden)
        .ignoresSafeArea(edges: .bottom)
    }
    
    func matchHistoryRow(match: CompletedMatch) -> some View {
        Group {
            VStack(spacing: 8) {
                HStack {
                    matchHistoryRowAtletheView(imageUrl: match.redImage, name: match.redName, athleteType: .red, win: match.winner == "Red")
                    Spacer()
                    Text("vs.")
                        .foregroundColor(.theme.secondaryText)
                    
                    Spacer()
                    matchHistoryRowAtletheView(imageUrl: match.blueImage, name: match.blueName, athleteType: .blue, win: match.winner == "Blue")
                }
                if showResults {
                    HStack {
                        Group {
                            Text("Method: ")
                                .foregroundColor(Color.theme.secondaryText) +
                            Text(match.method)
                        }
                        Spacer()
                        Group {
                            Text("Rounds: ")
                                .foregroundColor(Color.theme.secondaryText) +
                            Text("\(match.round)")
                        }
                    }
                    .padding(.horizontal)
                    .font(.footnote)
                }
            }
        }
        .multilineTextAlignment(.center)
    }
    
    func matchHistoryRowAtletheView(imageUrl: String, name: String, athleteType: AthleteType, win: Bool) -> some View {
        VStack {
            ZStack {
                AthleteImagePreview(imageUrl: imageUrl, athleteType: athleteType, isSearchView: false)
                    .frame(height: 150)
                if win && showResults {
                    Text("WIN")
                        .padding(.horizontal, 8)
                        .background(Color.theme.darkRed)
                        .opacity(0.85)
                        .offset(y: 15)
                }
            }
            Text(name)
        }
    }
}
