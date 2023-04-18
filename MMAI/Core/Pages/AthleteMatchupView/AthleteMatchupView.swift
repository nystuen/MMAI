import SwiftUI
import Charts

struct AthleteMatchupView: View {
    
    @StateObject private var vm = AthleteMatchupViewModel()
    @State private var showTip = false
    @State private var currentTip = ""
    @State var presentSearchAthleteSheet = false
    
    let match: UpcomingMatch?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                if vm.isLoading {
                    ProgressView()
                        .animation(.easeInOut(duration: 0.5), value: vm.isLoading)
                }
                
                GeometryReader { geometry in
                    ScrollView {
                        VStack(spacing: 12) {
                            if let ct = vm.comparisonTable {
                                athleteButtonImages(athleteA: vm.athleteA, athleteB: vm.athleteB)
                                Group {
                                    Group {
                                        Divider()
                                        predictButton(predictionResult: vm.predictionResult, isPredicting: $vm.isPredicting)
                                        Divider()
                                    }
                                    Group {
                                        VStack(spacing: 8) {
                                            statsRow(ct.age.0, "Age", ct.age.1)
                                            statsRow(ct.weightClass.0, "Weight class", ct.weightClass.1)
                                            statsRow(ct.record.0, "Record", ct.record.1)
                                        }
                                        Divider()
                                        VStack(spacing: 8) {
                                            statsRow(ct.height.0, "Height", ct.height.1, dominantAthlete: ct.dominantHeight)
                                            statsRow(ct.weight.0, "Weight ", ct.weight.1, dominantAthlete: ct.dominantWeight)
                                            statsRow(ct.reach.0, "Reach", ct.reach.1, dominantAthlete: ct.dominantReach)
                                            statsRow(ct.takedownAccuracy.0, "TA", centerRowTip: "Takedown Accuracy", ct.takedownAccuracy.1, dominantAthlete: ct.dominantTakedownAccuracy)
                                            statsRow(ct.strikingAccuracy.0, "SA", centerRowTip: "Striking Accuracy", ct.strikingAccuracy.1, dominantAthlete: ct.dominantStrikingAccuracy)
                                            statsRow(ct.atapm.0, "ATAPM ", centerRowTip: "Averange takedown attempts per minute" , ct.atapm.1, dominantAthlete: ct.dominantAtapm)
                                            statsRow(ct.asapm.0, "ASAPM", centerRowTip: "Average submission attempts per minute", ct.asapm.1, dominantAthlete: ct.dominantAsapm)
                                        }
                                        Divider()
                                        significantStrikesLandedPerMinuteChart(ct: ct)
                                        defenceInPercentageChart(ct: ct)
                                        Spacer()
                                    }
                                }
                            }
                            else if match == nil {
                                initialAthletePicker
                            }
                        }
                        .animation(.easeInOut(duration: 0.5), value: vm.comparisonTable)
                        .frame(minHeight: geometry.size.height)
                        .frame(width: geometry.size.width)
                    }
                }
                
                if showTip {
                    ZStack {
                        Color.theme.background
                            .ignoresSafeArea()
                            .opacity(0.97)
                            .transition(.opacity)
                        Text(currentTip)
                    }
                    .onTapGesture {
                        showTip.toggle()
                    }
                }
            }
        }
        .sheet(isPresented: $presentSearchAthleteSheet, content: {
            SearchAthleteView(searchTerm: $vm.athleteSearchTerm)
                .presentationDetents([.medium, .large])
        })
        .onAppear {
            if let match = match {
                vm.onAppear(match: match)
            }
        }
    }
}

struct UpcomingFightView_Previews: PreviewProvider {
    static var previews: some View {
        AthleteMatchupView(match: dev.match)
    }
}

extension AthleteMatchupView {
    var initialAthletePicker: some View {
        VStack {
            switch vm.initialAthletePickerStep {
            case 0:
                Text("Tap to select red athlete")
                    .font(.headline)
                    .foregroundColor(.theme.red)
                Button {
                    vm.athleteSearchCorner = .red
                    presentSearchAthleteSheet.toggle()
                } label: {
                    AthleteImageView(athlete: vm.athleteA, athleteType: nil)
                        .frame(height: 300)
                }
            case 1:
                Text("Tap to select blue athlete")
                    .font(.headline)
                    .foregroundColor(.theme.blue)
                Button {
                    vm.athleteSearchCorner = .blue
                    presentSearchAthleteSheet.toggle()
                } label: {
                    AthleteImageView(athlete: vm.athleteB, athleteType: nil)
                        .frame(height: 300)
                }
            default:
                Text("Unknown state")
            }
        }
        .animation(.easeInOut, value: vm.initialAthletePickerStep)
    }
    
    func predictButton(predictionResult: PredictionResult?, isPredicting: Binding<Bool>) -> some View {
        ZStack {
            switch predictionResult {
            case .none:
                ProgressButton(isLoading: isPredicting)
                    .scaleEffect(predictionResult == nil ? 1.0 : 0.0)
                    .opacity(predictionResult == nil ? 1.0 : 0.0)
            case .success(let result):
                ZStack {
                    Text(result.name)
                        .fontWeight(.bold)
                    +
                    Text(" will win by a probability of ")
                    +
                    Text(result.prob.asPercentString())
                        .fontWeight(.bold)
                }
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundColor(.theme.text)
                .scaleEffect(predictionResult != nil ? 1.0 : 0.0)
                .opacity(predictionResult != nil ? 1.0 : 0.0)
            case .failure(let error):
                Text(error)
            }
        }
        .animation(.easeInOut(duration: 0.75), value: predictionResult)
        .frame(minHeight: 60)
    }
    
    func athleteButtonImages(athleteA: Athlete?, athleteB: Athlete?) -> some View {
        HStack {
            Button {
                vm.athleteSearchCorner = .red
                presentSearchAthleteSheet.toggle()
            } label: {
                AthleteImageView(athlete: athleteA, athleteType: .red)
                    .animation(.easeInOut(duration: 0.25), value: vm.athleteA)
            }
            Button {
                vm.athleteSearchCorner = .blue
                presentSearchAthleteSheet.toggle()
            } label: {
                AthleteImageView(athlete: athleteB, athleteType: .blue)
                    .animation(.easeInOut(duration: 0.25), value: vm.athleteB)
            }
        }
        .font(.headline)
        .fontWeight(.regular)
        .padding(.horizontal, 32)
    }
    
    func statsRow(_ leftRow: String, _ centerRow: String, centerRowTip: String? = nil, _ rightRow: String, dominantAthlete: AthleteType? = nil) -> some View {
        HStack {
            HStack {
                if dominantAthlete == .red {
                    Text("D")
                        .opacity(1)
                        .fontWeight(.semibold)
                        .foregroundColor(.theme.red )
                    
                }
                Text(leftRow)
            }
            .frame(width: UIScreen.main.bounds.width / 2.5, alignment: .trailing)
            
            Text(centerRow)
                .frame(width: UIScreen.main.bounds.width / 5, alignment: .center)
                .onTapGesture {
                    if let centerRowTip = centerRowTip {
                        currentTip = centerRowTip
                        showTip.toggle()
                    }
                }
            
            HStack {
                Text(rightRow)
                if dominantAthlete == .blue {
                    Text("D")
                        .fontWeight(.heavy)
                        .foregroundColor(.theme.blue)
                }
            }
            .frame(width: UIScreen.main.bounds.width / 2.5, alignment: .leading)
        }
        .font(.subheadline)
        .foregroundColor(.theme.text)
        .multilineTextAlignment(.center)
    }
    
    func significantStrikesLandedPerMinuteChart(ct: AthleteComparisonTable) -> some View {
        VStack {
            Text("Significant strikes landed per minute")
                .fontWeight(.semibold)
                .font(.subheadline)
                .foregroundColor(.theme.text)
                .multilineTextAlignment(.center)
            Chart {
                BarMark(x: .value("Landed", 0.2),
                        y: .value("Landed", ct.sigStrikesLpm.0),
                        width: 20)
                .foregroundStyle(Color.theme.darkRed)
                BarMark(x: .value("Landed", 0.4),
                        y: .value("Landed", ct.sigStrikesLpm.1),
                        width: 20)
                .foregroundStyle(Color.theme.darkBlue)
                BarMark(x: .value("Absorbed", 1.6),
                        y: .value("Absorbed", ct.sigStrikesApm.0),
                        width: 20)
                .foregroundStyle(Color.theme.darkRed)
                BarMark(x: .value("Abosrbed", 1.8),
                        y: .value("Abosrbed", ct.sigStrikesApm.1),
                        width: 20)
                .foregroundStyle(Color.theme.darkBlue)
            }
            .chartXScale(domain: 0...2)
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
    
    func defenceInPercentageChart(ct: AthleteComparisonTable) -> some View {
        VStack {
            Text("Defence in %")
                .fontWeight(.semibold)
                .font(.subheadline)
                .foregroundColor(.theme.text)
            
            Chart {
                BarMark(x: .value("Takedown", 0.2),
                        y: .value("Takedown", ct.takedownDeference.0),
                        width: 20)
                .foregroundStyle(Color.theme.darkRed)
                BarMark(x: .value("Takedown", 0.4),
                        y: .value("Takedown", ct.takedownDeference.1),
                        width: 20)
                .foregroundStyle(Color.theme.darkBlue)
                BarMark(x: .value("Striking", 1.6),
                        y: .value("Striking", ct.strikesDeference.0),
                        width: 20)
                .foregroundStyle(Color.theme.darkRed)
                
                BarMark(x: .value("Striking", 1.8),
                        y: .value("Striking", ct.strikesDeference.1),
                        width: 20)
                .foregroundStyle(Color.theme.darkBlue)
            }
            .chartXScale(domain: 0...2)
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

