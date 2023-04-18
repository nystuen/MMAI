import SwiftUI
import CoreHaptics

import Foundation

struct EventPickerView<T: Event>: View {
    @EnvironmentObject var vm: EventPickerViewModel<T>
    
    var body: some View {
        HStack {
            Button {
                vm.updateSelectedEvent(increment: false)
            } label: {
                Text("<")
            }
            .disabled(vm.previousEventButtonIsDisabled)
            .opacity(vm.previousEventButtonIsDisabled ? 0.5 : 1)
            
            Spacer()
            
            tabViewPicker
            
            Spacer()
            
            Button {
                vm.updateSelectedEvent(increment: true)
            } label: {
                Text(">")
            }
            .disabled(vm.nextEventButtonIsDisabled)
            .opacity(vm.nextEventButtonIsDisabled ? 0.5 : 1)
        }
        .font(.headline)
        .foregroundColor(.theme.text)
        .padding()
    }
}

extension EventPickerView {
    var tabViewPicker: some View {
        TabView(selection: $vm.selectedEventIndex) {
            ForEach(0..<vm.events.count, id: \.self) { index in
                Text(vm.events[index].eventName)
                    .tag(index)
            }
        }
        .foregroundColor(.theme.red)
        .fontWeight(.medium)
        .multilineTextAlignment(.center)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct EventPickerViewPreviews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            dev.eventPickerView
                .environmentObject(dev.eventPickerViewModel)
        }
    }
}
