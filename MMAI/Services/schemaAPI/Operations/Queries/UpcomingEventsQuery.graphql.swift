// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SchemaAPI {
  class UpcomingEventsQuery: GraphQLQuery {
    public static let operationName: String = "UpcomingEvents"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query UpcomingEvents {
          upcomingEvents {
            __typename
            eventName
            location
            date
            fights {
              __typename
              fighter1
              fighter2
              weightClass
              redImage
              blueImage
            }
          }
        }
        """#
      ))

    public init() {}

    public struct Data: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("upcomingEvents", [UpcomingEvent].self),
      ] }

      public var upcomingEvents: [UpcomingEvent] { __data["upcomingEvents"] }

      /// UpcomingEvent
      ///
      /// Parent Type: `UpcomingEventType`
      public struct UpcomingEvent: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.UpcomingEventType }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("eventName", String?.self),
          .field("location", String?.self),
          .field("date", String?.self),
          .field("fights", [Fight].self),
        ] }

        public var eventName: String? { __data["eventName"] }
        public var location: String? { __data["location"] }
        public var date: String? { __data["date"] }
        public var fights: [Fight] { __data["fights"] }

        /// UpcomingEvent.Fight
        ///
        /// Parent Type: `UpcomingFightType`
        public struct Fight: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.UpcomingFightType }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("fighter1", String?.self),
            .field("fighter2", String?.self),
            .field("weightClass", String?.self),
            .field("redImage", String?.self),
            .field("blueImage", String?.self),
          ] }

          public var fighter1: String? { __data["fighter1"] }
          public var fighter2: String? { __data["fighter2"] }
          public var weightClass: String? { __data["weightClass"] }
          public var redImage: String? { __data["redImage"] }
          public var blueImage: String? { __data["blueImage"] }
        }
      }
    }
  }

}