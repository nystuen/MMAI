// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SchemaAPI {
  class PredictWinnerQuery: GraphQLQuery {
    public static let operationName: String = "PredictWinner"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query PredictWinner($redName: String!, $blueName: String!) {
          predictedWinner(redName: $redName, blueName: $blueName) {
            __typename
            name
            prob
          }
        }
        """#
      ))

    public var redName: String
    public var blueName: String

    public init(
      redName: String,
      blueName: String
    ) {
      self.redName = redName
      self.blueName = blueName
    }

    public var __variables: Variables? { [
      "redName": redName,
      "blueName": blueName
    ] }

    public struct Data: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("predictedWinner", PredictedWinner.self, arguments: [
          "redName": .variable("redName"),
          "blueName": .variable("blueName")
        ]),
      ] }

      public var predictedWinner: PredictedWinner { __data["predictedWinner"] }

      /// PredictedWinner
      ///
      /// Parent Type: `PredictedWinnerType`
      public struct PredictedWinner: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PredictedWinnerType }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("name", String.self),
          .field("prob", Double.self),
        ] }

        public var name: String { __data["name"] }
        public var prob: Double { __data["prob"] }
      }
    }
  }

}