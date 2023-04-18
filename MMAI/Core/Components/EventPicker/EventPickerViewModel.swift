import Foundation
import Combine

class EventPickerViewModel<T: Event>: ObservableObject {
    @Published var events: [T] = []
    @Published var selectedEvent: T?
    @Published var selectedEventIndex = 0
    
    @Published var previousEventButtonIsDisabled = true
    @Published var nextEventButtonIsDisabled = false
    
    var cancellable = Set<AnyCancellable>()
    
    let eventService: RemoteEventService<T>
    
    init(eventService: RemoteEventService<T>) {
        self.eventService = eventService
        setUpSubscribers()
    }
    
    func setUpSubscribers() {
        $selectedEventIndex
            .sink { [weak self] newIndex in
                guard let self = self else { return }
                if let selectedEvent = self.events[safe: newIndex] {
                    self.selectedEvent = selectedEvent
                    self.updateNavigateEventButtonState(index: newIndex)
                    HapticsManager.vibrate(withIntensity: .medium)
                }
            }
            .store(in: &cancellable)
        
        eventService.$events
            .sink { [weak self] events in
                guard let self = self else { return }
                
                self.events = events?.compactMap { $0 } as? [T] ?? []
                self.selectedEvent = events?.first
            }
            .store(in: &cancellable)
    }
    
    func updateSelectedEvent(increment: Bool) {
        selectedEventIndex = selectedEventIndex + (increment ? 1 : -1)
    }
    
    func updateNavigateEventButtonState(index: Int) {
        previousEventButtonIsDisabled = index == 0
        nextEventButtonIsDisabled = index == events.count - 1
    }
}
