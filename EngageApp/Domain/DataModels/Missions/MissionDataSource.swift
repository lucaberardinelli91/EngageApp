//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct MissionDataSource: Decodable {
    public let id: String?
    public let points: Int?
    public let maxPoints: Int?
    public let answeredPoints: Int?
    public let correctPoints: Int?
    public let seconds: Int?
    public let contestId: String?
    public let label: String?
    public let provider: String?
    public let presenter: MissionItemDataPresenterDataSource?
    public let campaignId: String?
    public let createdAt: String?
    public let updatedAt: String?
    public let deletedAt: String?
    public let claim: String?
    public let available: Bool?
    public let type: String?
    public var title: String?
    public var totalQuestions: Int?
    public var cta: String?
    public let content: String?
    public let schedules: [ItemScheduleDataSource]?
    public var mission: MissionItemDataSource?

    enum CodingKeys: String, CodingKey {
        case id
        case points
        case max_points
        case answered_points
        case correct_points
        case seconds
        case contest_id
        case label
        case provider
        case presenter
        case campaign_id
        case created_at
        case updated_at
        case deleted_at
        case claim
        case available
        case type
        case title
        case total_questions
        case cta
        case content
        case schedules
        case mission
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        points = try values.decodeIfPresent(Int.self, forKey: .points)
        maxPoints = try values.decodeIfPresent(Int.self, forKey: .max_points)
        answeredPoints = try values.decodeIfPresent(Int.self, forKey: .answered_points)
        correctPoints = try values.decodeIfPresent(Int.self, forKey: .correct_points)
        seconds = try values.decodeIfPresent(Int.self, forKey: .seconds)
        contestId = try values.decodeIfPresent(String.self, forKey: .contest_id)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        provider = try values.decodeIfPresent(String.self, forKey: .provider)
        presenter = try values.decodeIfPresent(MissionItemDataPresenterDataSource.self, forKey: .presenter)
        campaignId = try values.decodeIfPresent(String.self, forKey: .campaign_id)
        createdAt = try values.decodeIfPresent(String.self, forKey: .created_at)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updated_at)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        claim = try values.decodeIfPresent(String.self, forKey: .claim)
        available = try values.decodeIfPresent(Bool.self, forKey: .available)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        totalQuestions = try values.decodeIfPresent(Int.self, forKey: .total_questions)
        cta = try values.decodeIfPresent(String.self, forKey: .cta)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        schedules = try values.decodeIfPresent([ItemScheduleDataSource].self, forKey: .schedules)
        mission = try values.decodeIfPresent(MissionItemDataSource.self, forKey: .mission)
    }
}

public struct MissionItemDataSource: Decodable {
    public let id: String?
    public let campaignId: String?
    public let resourceId: String?
    public let resourceType: String?
    public let createdAt: String?
    public let updatedAt: String?
    public let deletedAt: String?
    public let schedules: [ItemSchedule]?

    private enum CodingKeys: String, CodingKey {
        case id
        case campaign_id
        case resource_id
        case resource_type
        case created_at
        case updated_at
        case deleted_at
        case schedules
    }

    public init() {
        id = ""
        campaignId = ""
        resourceId = ""
        resourceType = ""
        createdAt = ""
        updatedAt = ""
        deletedAt = ""
        schedules = []
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        campaignId = try values.decodeIfPresent(String.self, forKey: .campaign_id)
        resourceId = try values.decodeIfPresent(String.self, forKey: .resource_id)
        resourceType = try values.decodeIfPresent(String.self, forKey: .resource_type)
        createdAt = try values.decodeIfPresent(String.self, forKey: .created_at)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updated_at)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        schedules = try values.decodeIfPresent([ItemSchedule].self, forKey: .schedules)
    }
}

public struct ItemScheduleDataSource: Decodable {
    public var id: String?
    public var startAt: String?
    public var endAt: String?
    public var missionId: String?
    public var campaignId: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var deletedAt: String?
    public var claim: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case start_at
        case end_at
        case mission_id
        case campaign_id
        case created_at
        case updated_at
        case deleted_at
        case claim
    }

    public init() {}

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        startAt = try values.decodeIfPresent(String.self, forKey: .start_at)
        endAt = try values.decodeIfPresent(String.self, forKey: .end_at)
        missionId = try values.decodeIfPresent(String.self, forKey: .mission_id)
        campaignId = try values.decodeIfPresent(String.self, forKey: .campaign_id)
        createdAt = try values.decodeIfPresent(String.self, forKey: .created_at)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updated_at)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        claim = try values.decodeIfPresent(String.self, forKey: .claim)
    }
}

public struct MissionItemDataPresenterDataSource: Decodable {
    public var id = UUID()
    public var label: String?

    private enum CodingKeys: String, CodingKey {
        case label
    }

    public init() {}

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
}
