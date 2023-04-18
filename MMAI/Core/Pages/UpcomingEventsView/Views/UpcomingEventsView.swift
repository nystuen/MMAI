import SwiftUI

struct UpcomingEventsView: View {
    
    @StateObject private var pickerVm = EventPickerViewModel<UpcomingEvent>(eventService: RemoteEventService<UpcomingEvent>())
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                if let event = pickerVm.selectedEvent {
                    ScrollView {
                        VStack(alignment: .center, spacing: 4) {
                            
                            EventPickerView<UpcomingEvent>()
                                .environmentObject(pickerVm)
                            
                            VStack {
                                Text(event.location)
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

struct UpcomingEventsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventsView()
    }
}

extension UpcomingEventsView {
    private func matchesListView(matches: [UpcomingMatch]) -> some View {
        return LazyVStack {
            ForEach(matches) { match in
                NavigationLink {
                    AthleteMatchupView(match: match).toolbar(.hidden, for: .tabBar)
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
    
    func matchHistoryRow(match: UpcomingMatch) -> some View {
        Group {
            VStack(spacing: 8) {
                HStack {
                    matchHistoryRowAtletheView(imageUrl: match.redImage, name: match.redName, athleteType: .red)
                    Spacer()
                    Text("vs.")
                        .foregroundColor(.theme.secondaryText)
                    Spacer()
                    matchHistoryRowAtletheView(imageUrl: match.blueImage, name: match.blueName, athleteType: .blue)
                }
            }
        }
        .multilineTextAlignment(.center)
    }
    
    func matchHistoryRowAtletheView(imageUrl: String, name: String, athleteType: AthleteType) -> some View {
        VStack {
            ZStack {
                AthleteImagePreview(imageUrl: imageUrl, athleteType: athleteType, isSearchView: false)
                    .frame(height: 150)
            }
            Text(name)
        }
    }
    /*
     
    private func matchesListView(matches: [UpcomingMatch]) -> some View {
        return LazyVStack {
            if let matches = matches {
                ForEach(matches) { match in
                    ZStack {
                        NavigationLink {
                            AthleteMatchupView(match: match).toolbar(.hidden, for: .tabBar)
                        } label: {
                            HStack(spacing: 8) {
                                VStack(spacing: 0) {
                                    AthleteImagePreview(imageUrl: match.redImage, athleteType: .red, isSearchView: false)
                                        .frame(height: 150)
                                    Text(match.redName)
                                }
                                Spacer()
                                Text("vs.")
                                    .foregroundColor(.theme.secondaryText)
                                
                                Spacer()
                                VStack(spacing: 0) {
                                    AthleteImagePreview(imageUrl: match.blueImage, athleteType: .blue, isSearchView: false)
                                    Text(match.blueName)
                                }
                            }
                            .foregroundColor(.theme.text)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                        }
                    }
                }
                .listRowBackground(Color.theme.background)
            }
        }
        .padding(.horizontal, 4)
        .listStyle(.plain)
        .buttonStyle(.plain)
        .scrollContentBackground(.hidden)
        .ignoresSafeArea(edges: .bottom)
        .font(.footnote)
        .multilineTextAlignment(.center)
    }
     */
}
