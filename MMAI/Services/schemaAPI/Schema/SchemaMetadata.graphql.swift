// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SchemaAPI_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SchemaAPI.SchemaMetadata {}

public protocol SchemaAPI_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SchemaAPI.SchemaMetadata {}

public protocol SchemaAPI_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SchemaAPI.SchemaMetadata {}

public protocol SchemaAPI_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SchemaAPI.SchemaMetadata {}

public extension SchemaAPI {
  typealias ID = String

  typealias SelectionSet = SchemaAPI_SelectionSet

  typealias InlineFragment = SchemaAPI_InlineFragment

  typealias MutableSelectionSet = SchemaAPI_MutableSelectionSet

  typealias MutableInlineFragment = SchemaAPI_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Query": return SchemaAPI.Objects.Query
      case "PredictedWinnerType": return SchemaAPI.Objects.PredictedWinnerType
      case "MatchHistoryType": return SchemaAPI.Objects.MatchHistoryType
      case "CompletedEventType": return SchemaAPI.Objects.CompletedEventType
      case "FighterType": return SchemaAPI.Objects.FighterType
      case "UpcomingEventType": return SchemaAPI.Objects.UpcomingEventType
      case "UpcomingFightType": return SchemaAPI.Objects.UpcomingFightType
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}