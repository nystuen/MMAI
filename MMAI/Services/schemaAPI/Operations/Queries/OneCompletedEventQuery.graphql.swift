// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SchemaAPI {
  class OneCompletedEventQuery: GraphQLQuery {
    public static let operationName: String = "OneCompletedEvent"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query OneCompletedEvent($eventName: String!, $date: String!) {
          oneCompletedEvent(eventName: $eventName, date: $date) {
            __typename
            redName
            blueName
            referee
            time
            method
            weightClass
            round
            winner
            eventName
            redImage
            blueImage
            totalRed
            totalBlue
            strikesRed
            strikesBlue
            tdRed
            tdBlue
            passRed
            passBlue
            revRed
            revBlue
            subRed
            subBlue
            clinchRed
            clinchBlue
            groundRed
            groundBlue
            distanceRed
            distanceBlue
            headRed
            headBlue
            bodyRed
            bodyBlue
            legRed
            legBlue
          }
        }
        """#
      ))

    public var eventName: String
    public var date: String

    public init(
      eventName: String,
      date: String
    ) {
      self.eventName = eventName
      self.date = date
    }

    public var __variables: Variables? { [
      "eventName": eventName,
      "date": date
    ] }

    public struct Data: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("oneCompletedEvent", [OneCompletedEvent].self, arguments: [
          "eventName": .variable("eventName"),
          "date": .variable("date")
        ]),
      ] }

      public var oneCompletedEvent: [OneCompletedEvent] { __data["oneCompletedEvent"] }

      /// OneCompletedEvent
      ///
      /// Parent Type: `MatchHistoryType`
      public struct OneCompletedEvent: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MatchHistoryType }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("redName", String?.self),
          .field("blueName", String?.self),
          .field("referee", String?.self),
          .field("time", String?.self),
          .field("method", String?.self),
          .field("weightClass", String?.self),
          .field("round", String?.self),
          .field("winner", String?.self),
          .field("eventName", String?.self),
          .field("redImage", String?.self),
          .field("blueImage", String?.self),
          .field("totalRed", String?.self),
          .field("totalBlue", String?.self),
          .field("strikesRed", String?.self),
          .field("strikesBlue", String?.self),
          .field("tdRed", String?.self),
          .field("tdBlue", String?.self),
          .field("passRed", String?.self),
          .field("passBlue", String?.self),
          .field("revRed", String?.self),
          .field("revBlue", String?.self),
          .field("subRed", String?.self),
          .field("subBlue", String?.self),
          .field("clinchRed", String?.self),
          .field("clinchBlue", String?.self),
          .field("groundRed", String?.self),
          .field("groundBlue", String?.self),
          .field("distanceRed", String?.self),
          .field("distanceBlue", String?.self),
          .field("headRed", String?.self),
          .field("headBlue", String?.self),
          .field("bodyRed", String?.self),
          .field("bodyBlue", String?.self),
          .field("legRed", String?.self),
          .field("legBlue", String?.self),
        ] }

        public var redName: String? { __data["redName"] }
        public var blueName: String? { __data["blueName"] }
        public var referee: String? { __data["referee"] }
        public var time: String? { __data["time"] }
        public var method: String? { __data["method"] }
        public var weightClass: String? { __data["weightClass"] }
        public var round: String? { __data["round"] }
        public var winner: String? { __data["winner"] }
        public var eventName: String? { __data["eventName"] }
        public var redImage: String? { __data["redImage"] }
        public var blueImage: String? { __data["blueImage"] }
        public var totalRed: String? { __data["totalRed"] }
        public var totalBlue: String? { __data["totalBlue"] }
        public var strikesRed: String? { __data["strikesRed"] }
        public var strikesBlue: String? { __data["strikesBlue"] }
        public var tdRed: String? { __data["tdRed"] }
        public var tdBlue: String? { __data["tdBlue"] }
        public var passRed: String? { __data["passRed"] }
        public var passBlue: String? { __data["passBlue"] }
        public var revRed: String? { __data["revRed"] }
        public var revBlue: String? { __data["revBlue"] }
        public var subRed: String? { __data["subRed"] }
        public var subBlue: String? { __data["subBlue"] }
        public var clinchRed: String? { __data["clinchRed"] }
        public var clinchBlue: String? { __data["clinchBlue"] }
        public var groundRed: String? { __data["groundRed"] }
        public var groundBlue: String? { __data["groundBlue"] }
        public var distanceRed: String? { __data["distanceRed"] }
        public var distanceBlue: String? { __data["distanceBlue"] }
        public var headRed: String? { __data["headRed"] }
        public var headBlue: String? { __data["headBlue"] }
        public var bodyRed: String? { __data["bodyRed"] }
        public var bodyBlue: String? { __data["bodyBlue"] }
        public var legRed: String? { __data["legRed"] }
        public var legBlue: String? { __data["legBlue"] }
      }
    }
  }

}