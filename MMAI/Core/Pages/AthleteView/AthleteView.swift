import SwiftUI
import Charts

struct AthleteView: View {
    
    @StateObject private var vm = AthleteViewModel()
    @State private var presentSearchAthleteSheet = false
    @State private var scrollToTop = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                GeometryReader { geometry in
                    ScrollViewReader { reader in
                        ScrollView {
                            VStack {
                                ScrollerToTop(reader: reader, scrollOnChange: $scrollToTop)
                                VStack(spacing: 16) {
                                    VStack {
                                        if vm.athlete == nil {
                                            Text("Tap to select athlete")
                                                .font(.headline)
                                                .foregroundColor(.theme.text)
                                        }
                                        Button {
                                            presentSearchAthleteSheet.toggle()
                                        } label: {
                                            AthleteImageView(athlete: vm.athlete, athleteType: nil)
                                                .frame(height: 300)
                                        }
                                    }
                                    if let st = vm.statsTable {
                                        stats(statsTable: st)
                                    }
                                }
                                .animation(.easeInOut(duration: 0.75), value: vm.statsTable)
                                .frame(minHeight: geometry.size.height)
                                .frame(width: geometry.size.width)
                                .foregroundColor(.theme.text)
                            }
                            //.animation(.spring(), value: vm.statsTable)
                        }
                    }
                }
                .padding(.horizontal)
                
            }
        }
        .sheet(isPresented: $presentSearchAthleteSheet, content: {
            SearchAthleteView(searchTerm: $vm.athleteSearchTerm)
                .presentationDetents([.medium, .large])
        })
    }
}

struct AthleteView_Previews: PreviewProvider {
    static var previews: some View {
        AthleteView()
    }
}

extension AthleteView {
    func stats(statsTable st: AthleteStatsTable) -> some View {
        VStack {
            Divider()
            Group {
                statsRow(leftRow: "Age", rightRow: st.age)
                statsRow(leftRow: "Weight class", rightRow: st.weightClass)
                statsRow(leftRow: "Record", rightRow: st.record)
                Divider()
                statsRow(leftRow: "Height", rightRow: st.height)
                statsRow(leftRow: "Weight", rightRow: st.weight)
                statsRow(leftRow: "Reach", rightRow: st.reach)
                statsRow(leftRow: "Takedown accuracy", rightRow: st.takedownAccuracy)
                statsRow(leftRow: "Avg. takedown attempts per match", rightRow: st.atapm)
                statsRow(leftRow: "Avg. submission attempts per match", rightRow: st.asapm)
            }
            .transition(.opacity)
            Group {
                Divider()
                significantStrikesLandedPerMinuteChart(st: st)
                Divider()
                defenceInPercentageChart(st: st)
                Divider()
                matchHistory(matchHistory: vm.athlete?.matchHistory)
            }
        }
    }
    
    func statsRow(leftRow: String, rightRow: String) -> some View {
        HStack {
            Text(leftRow)
            Spacer()
            Text(rightRow)
        }
    }
    
    func matchHistory(matchHistory: [Match]?) -> some View {
        VStack {
            Text("Match history")
                .fontWeight(.semibold)
                .font(.subheadline)
                .foregroundColor(.theme.text)
            ForEach(matchHistory ?? []) {
                matchHistoryRow(match: $0)
                    .padding()
                Divider()
            }
        }
    }
    
    
    func matchHistoryRowAtletheView(imageUrl: String, name: String, athleteType: AthleteType, win: Bool) -> some View {
        VStack {
            Button {
                if vm.athlete?.name != name {
                    vm.searchForAthlete(name: name)
                }
                scrollToTop.toggle()
            } label: {
                ZStack {
                    AthleteImagePreview(imageUrl: imageUrl, athleteType: athleteType, isSearchView: false)
                        .frame(height: 150)
                    if win {
                        Text("WIN")
                            .padding(.horizontal, 8)
                            .background(Color.theme.darkRed)
                            .opacity(0.85)
                            .offset(y: 15)
                    }
                }
            }
            Text(name)
        }
    }
    
    func matchHistoryRow(match: Match) -> some View {
        Group {
            VStack(spacing: 16) {
                HStack {
                    matchHistoryRowAtletheView(imageUrl: match.redImage, name: match.redName, athleteType: .red, win: match.winner == "Red")
                    matchHistoryRowAtletheView(imageUrl: match.blueImage, name: match.blueName, athleteType: .blue, win: match.winner == "Blue")
                }
                HStack {
                    Text(match.date)
                        .foregroundColor(Color.theme.secondaryText)
                    Spacer()
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
                .font(.footnote)
                .multilineTextAlignment(.center)
            }
        }
    }
    
    func significantStrikesLandedPerMinuteChart(st: AthleteStatsTable) -> some View {
        VStack {
            Text("Significant strikes landed per minute")
                .fontWeight(.semibold)
                .font(.subheadline)
                .foregroundColor(.theme.text)
                .multilineTextAlignment(.center)
            
            Chart {
                BarMark(x: .value("Landed", 0.2),
                        y: .value("Landed", st.sigStrikesLpm),
                        width: 20)
                .foregroundStyle(Color.theme.darkRed)
                BarMark(x: .value("Absorbed", 0.9),
                        y: .value("Absorbed", st.sigStrikesApm),
                        width: 20)
                .foregroundStyle(Color.theme.darkRed)
            }
            .chartXScale(domain: 0...1)
            .chartXAxis(.hidden)
            
            HStack {
                Text("Landed")
                Spacer()
                Text("Absorbed")
            }
            .foregroundColor(.theme.secondaryText)
            .padding(.horizontal, 15)
        }
        .frame(height: 300)
        .padding(.horizontal, 50)
    }
    
    func defenceInPercentageChart(st: AthleteStatsTable) -> some View {
        VStack {
            Text("Defence in %")
                .fontWeight(.semibold)
                .font(.subheadline)
                .foregroundColor(.theme.text)
            
            Chart {
                BarMark(x: .value("Takedown", 0.2),
                        y: .value("Takedown", st.takedownDeference),
                        width: 20)
                .foregroundStyle(Color.theme.darkRed)
                BarMark(x: .value("Striking", 0.9),
                        y: .value("Striking", st.strikesDeference),
                        width: 20)
                .foregroundStyle(Color.theme.darkRed)
            }
            .chartXScale(domain: 0...1)
            .chartXAxis(.hidden)
            
            HStack {
                Text("Takedown")
                Spacer()
                Text("Striking")
            }
            .foregroundColor(.theme.secondaryText)
            .padding(.horizontal, 15)
        }
        .frame(height: 300)
        .padding(.horizontal, 50)
        
    }
}
