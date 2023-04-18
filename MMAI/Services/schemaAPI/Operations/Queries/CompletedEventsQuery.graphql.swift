// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SchemaAPI {
  class CompletedEventsQuery: GraphQLQuery {
    public static let operationName: String = "CompletedEvents"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query CompletedEvents {
          completedEvents {
            __typename
            eventName
            date
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
        .field("completedEvents", [CompletedEvent].self),
      ] }

      public var completedEvents: [CompletedEvent] { __data["completedEvents"] }

      /// CompletedEvent
      ///
      /// Parent Type: `CompletedEventType`
      public struct CompletedEvent: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.CompletedEventType }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("eventName", String?.self),
          .field("date", String?.self),
        ] }

        public var eventName: String? { __data["eventName"] }
        public var date: String? { __data["date"] }
      }
    }
  }

}