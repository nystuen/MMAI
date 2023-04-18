// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SchemaAPI {
  class AllFightersQuery: GraphQLQuery {
    public static let operationName: String = "AllFighters"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query AllFighters {
          allFighters {
            __typename
            name
            image
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
        .field("allFighters", [AllFighter].self),
      ] }

      public var allFighters: [AllFighter] { __data["allFighters"] }

      /// AllFighter
      ///
      /// Parent Type: `FighterType`
      public struct AllFighter: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.FighterType }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("name", String?.self),
          .field("image", String?.self),
        ] }

        public var name: String? { __data["name"] }
        public var image: String? { __data["image"] }
      }
    }
  }

}