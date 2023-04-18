// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SchemaAPI {
  class OneFighterQuery: GraphQLQuery {
    public static let operationName: String = "OneFighter"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query OneFighter($name: String!) {
          oneFighter(name: $name) {
            __typename
            name
            nickname
            record
            height
            heightCm
            weight
            weightKg
            weightClass
            reach
            reachCm
            stance
            birth
            slpm
            strikesAccuracy
            sapm
            strikesDefence
            takedownAverage
            takedownAccuracy
            takedownDefence
            submissionAverage
            record
            image
            matchHistory {
              __typename
              date
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
        }
        """#
      ))

    public var name: String

    public init(name: String) {
      self.name = name
    }

    public var __variables: Variables? { ["name": name] }

    public struct Data: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("oneFighter", OneFighter.self, arguments: ["name": .variable("name")]),
      ] }

      public var oneFighter: OneFighter { __data["oneFighter"] }

      /// OneFighter
      ///
      /// Parent Type: `FighterType`
      public struct OneFighter: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.FighterType }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("name", String?.self),
          .field("nickname", String?.self),
          .field("record", String?.self),
          .field("height", String?.self),
          .field("heightCm", Double.self),
          .field("weight", Int?.self),
          .field("weightKg", Double.self),
          .field("weightClass", String?.self),
          .field("reach", Int?.self),
          .field("reachCm", Double?.self),
          .field("stance", String?.self),
          .field("birth", String?.self),
          .field("slpm", Double?.self),
          .field("strikesAccuracy", Int?.self),
          .field("sapm", Double?.self),
          .field("strikesDefence", Double?.self),
          .field("takedownAverage", Double?.self),
          .field("takedownAccuracy", Int?.self),
          .field("takedownDefence", Int?.self),
          .field("submissionAverage", Double?.self),
          .field("image", String?.self),
          .field("matchHistory", [MatchHistory].self),
        ] }

        public var name: String? { __data["name"] }
        public var nickname: String? { __data["nickname"] }
        public var record: String? { __data["record"] }
        public var height: String? { __data["height"] }
        public var heightCm: Double { __data["heightCm"] }
        public var weight: Int? { __data["weight"] }
        public var weightKg: Double { __data["weightKg"] }
        public var weightClass: String? { __data["weightClass"] }
        public var reach: Int? { __data["reach"] }
        public var reachCm: Double? { __data["reachCm"] }
        public var stance: String? { __data["stance"] }
        public var birth: String? { __data["birth"] }
        public var slpm: Double? { __data["slpm"] }
        public var strikesAccuracy: Int? { __data["strikesAccuracy"] }
        public var sapm: Double? { __data["sapm"] }
        public var strikesDefence: Double? { __data["strikesDefence"] }
        public var takedownAverage: Double? { __data["takedownAverage"] }
        public var takedownAccuracy: Int? { __data["takedownAccuracy"] }
        public var takedownDefence: Int? { __data["takedownDefence"] }
        public var submissionAverage: Double? { __data["submissionAverage"] }
        public var image: String? { __data["image"] }
        public var matchHistory: [MatchHistory] { __data["matchHistory"] }

        /// OneFighter.MatchHistory
        ///
        /// Parent Type: `MatchHistoryType`
        public struct MatchHistory: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MatchHistoryType }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("date", String?.self),
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

          public var date: String? { __data["date"] }
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

}