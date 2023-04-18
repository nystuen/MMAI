
import SwiftUI
import Introspect

struct SearchAthleteView: View {
    @StateObject private var vm = SearchAthleteViewModel()
    @Binding var searchTerm: String
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var searchFieldIsFocused: Bool
    
    
    enum FocusField: Hashable {
        case field
    }
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 8) {
                searchField
                
                if vm.filteredAthletes.isEmpty {
                    Spacer()
                } else {
                    athleteList
                }
            }
            .padding(.top)
        }
        .onChange(of: searchTerm) { searchTerm in
            vm.searchOnChange(searchTerm: searchTerm)
        }
        .onAppear {
            searchTerm = ""
            searchFieldIsFocused = true
        }
    }
}

struct SearchAthleteView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAthleteView(searchTerm: .constant(""))
    }
}

extension SearchAthleteView {
    var searchField: some View {
        HStack {
            HStack {
                TextField("Search", text: $searchTerm)
                    .focused($searchFieldIsFocused)
                    .padding(.horizontal, 8)
                if (searchFieldIsFocused && !searchTerm.isEmpty) || !searchTerm.isEmpty {
                    Button {
                        searchTerm = ""
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .opacity(0.5)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            if searchFieldIsFocused || !searchTerm.isEmpty {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .padding()
    }
    
    var athleteList: some View {
        List {
            ForEach(vm.filteredAthletes) { athlete in
                HStack {
                    AthleteImagePreview(imageUrl: athlete.image, athleteType: .red, isSearchView: true)
                        .frame(width: 45, height: 45)
                    Text(athlete.name)
                        .font(.title3)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    searchTerm = athlete.name
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .listRowBackground(Color.theme.background)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}
