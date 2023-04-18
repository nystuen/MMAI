import Foundation
import Combine

protocol EventService {
    associatedtype Element
    var events: [Element]? { get }
    var eventsValue: Published<[Element]?> { get }
    var eventsPublisher: Published<[Element]?>.Publisher { get }
}

class RemoteEventService<T: Event>: EventService {
    
    @Published private(set) var events: [T]?
    @Published private(set) var eventsUnprocessed: [T]?
    
    var cancellables = Set<AnyCancellable>()
    
    var eventsValue: Published<[T]?> {
        return _events
    }
    
    var eventsPublisher: Published<[T]?>.Publisher {
        return $events
    }
    
    init () {
        switch T.self {
        case is UpcomingEvent.Type:
            NetworkingManager.shared.fetchUpcomingEvents() { [weak self] events in
                self?.events = events.compactMap { UpcomingEvent.process(queryData: $0) as? T }
            }
        case is CompletedEvent.Type:
            $eventsUnprocessed
                .sink { completedEvents in
                    completedEvents?.forEach { event in
                        NetworkingManager.shared.fetchOneCompletedEvent(eventName: event.eventName, date: event.date) { [weak self] completedMatches in
                            guard let self = self else { return }
                            var completedEvent = event as? CompletedEvent
                            completedEvent?.matches = completedMatches.reversed().compactMap { CompletedMatch.process(queryData: $0) }
                            guard let completedEvent = completedEvent as? T else { return }
                            if self.events != nil {
                                self.events?.append(completedEvent)
                            } else {
                                self.events = [completedEvent]
                            }
                        }
                    }
                }
                .store(in: &cancellables)
            
            NetworkingManager.shared.fetchCompletedEvents { [weak self] events in
                self?.eventsUnprocessed = events.prefix(10).compactMap { CompletedEvent.process(queryData: $0) as? T }
            }
        default:
            print("ERROR: Unkown EventService associated type")
        }
    }
}

