//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public enum MissionType: String {
    case survey
    case quiz
    case info
    case fancam
    case instantwin
    case identityTouchpoint
    case unknown
    
    init(_ string: String) {
        switch string.lowercased() {
        case let s where s.contains("survey"):
            self = .survey
        case let s where s.contains("information.read"):
            self = .info
        case let s where s.contains("upload"):
            self = .fancam
        case let s where s.contains("instantwin.random"):
            self = .instantwin
        case let s where s.contains("answer.instantwin"):
            self = .quiz
        case let s where s.contains("identity.touchpoint"):
            self = .identityTouchpoint
        default:
            self = .unknown
        }
    }
}

public enum IdentityTouchpointType: String {
    case socialGoogle
    case socialFacebook
    case socialTwitter
    case socialLinkedin
    case unknown
    
    init(_ string: String) {
        switch string.lowercased() {
        case let s where s.contains("google"):
            self = .socialGoogle
        case let s where s.contains("facebook"):
            self = .socialFacebook
        case let s where s.contains("twitter"):
            self = .socialTwitter
        case let s where s.contains("linkedin"):
            self = .socialLinkedin
        default:
            self = .unknown
        }
    }
}

public struct Mission: Decodable, Hashable {
    var id = UUID()
    public let type: String?
    public var data: MissionData?
    
    enum CodingKeys: String, CodingKey {
        case type
        case data
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        data = try values.decodeIfPresent(MissionData.self, forKey: .data)
    }
    
    public static func == (lhs: Mission, rhs: Mission) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func getMissions() -> [Mission] {
        return [Mission(1),
                Mission(4),
                Mission(6),
                Mission(8),
                Mission(2),
                Mission(3),
                Mission(5),
                Mission(7),
                Mission(9)]
    }
    
    public init(_ count: Int) {
        switch count {
            
            // Istantwin missions
        case 1:
            self.type = "instantwin.random"
            var missionData = MissionData()
            missionData.id = "1"
            missionData.points = 100
            missionData.title = "Tenta la fortuna!"
            self.data = missionData
        case 2:
            self.type = "instantwin.random"
            var missionData = MissionData()
            missionData.id = "1"
            missionData.points = 200
            missionData.title = "Tenta la fortuna!"
            self.data = missionData
        case 3:
            self.type = "instantwin.random"
            var missionData = MissionData()
            missionData.id = "1"
            missionData.points = 300
            missionData.title = "Tenta la fortuna!"
            self.data = missionData
            
            // Social missions
        case 4:
            self.type = "identity.touchpoint"
            var missionData = MissionData()
            missionData.id = "1"
            missionData.points = 555
            missionData.provider = "facebook"
            var presenter = MissionItemDataPresenter()
            presenter.label = "Facebook"
            missionData.presenter = presenter
            self.data = missionData
        case 5:
            self.type = "identity.touchpoint"
            var missionData = MissionData()
            missionData.id = "1"
            missionData.points = 350
            missionData.provider = "twitter"
            var presenter = MissionItemDataPresenter()
            presenter.label = "Twitter"
            missionData.presenter = presenter
            self.data = missionData
            
            // Readinfo missions
        case 6:
            self.type = "information.read"
            var missionData = MissionData()
            missionData.id = "1"
            missionData.points = 350
            missionData.createdAt = "2022-08-12 20:31:39"
            missionData.title = "Leggi il nuovo articolo"
            missionData.cta = "Ok, ho letto"
            missionData.content = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
            self.data = missionData
        case 7:
            self.type = "information.read"
            var missionData = MissionData()
            missionData.id = "1"
            missionData.points = 700
            missionData.createdAt = "2022-08-12 20:31:39"
            missionData.title = "La sai la novità?"
            missionData.cta = "Ok, ho letto"
            missionData.content = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
            self.data = missionData
            
            // Quiz missions
        case 8:
            self.type = "answer.instantwin"
            var missionData = MissionData()
            missionData.id = "1"
            missionData.claim = "Conquista nuovi coins"
            missionData.points = 40
            missionData.maxPoints = 130
            missionData.answeredPoints = 10
            missionData.correctPoints = 20
            missionData.seconds = 5
            missionData.points = 700
            missionData.createdAt = "2022-08-12 20:31:39"
            missionData.title = "Mettiti in gioco con questo nuovo quiz!"
            missionData.totalQuestions = 2
            missionData.cta = "Ok, ho letto"
            var schedule = ItemSchedule()
            schedule.endAt = "2022-08-28 15:00:00"
            missionData.schedules = [schedule]
            self.data = missionData
        case 9:
            self.type = "answer.instantwin"
            var missionData = MissionData()
            missionData.id = "1"
            missionData.claim = "Conquista nuovi coins"
            missionData.points = 40
            missionData.maxPoints = 300
            missionData.answeredPoints = 10
            missionData.correctPoints = 20
            missionData.seconds = 5
            missionData.points = 700
            missionData.createdAt = "2022-08-12 20:31:39"
            missionData.title = "Mettiti in gioco con questo nuovo quiz!"
            missionData.totalQuestions = 2
            missionData.cta = "Ok, ho letto"
            var schedule = ItemSchedule()
            schedule.endAt = "2022-08-28 15:00:00"
            missionData.schedules = [schedule]
            self.data = missionData
        default:
            self.type = "instantwin.random"
            var missionData = MissionData()
            missionData.points = 100
            missionData.title = "Tenta la fortuna!"
            self.data = missionData
        }
    }
}

// MARK: - Section Mission Data

public struct MissionData: Decodable, Hashable {
    public var id: String?
    public var points: Int?
    public var maxPoints: Int?
    public var answeredPoints: Int?
    public var correctPoints: Int?
    public var seconds: Int?
    public var contestId: String?
    public var label: String?
    public var provider: String?
    public var presenter: MissionItemDataPresenter?
    public var campaignId: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var deletedAt: String?
    public var claim: String?
    public var available: Bool?
    public var type: String?
    public var title: String?
    public var totalQuestions: Int?
    public var cta: String?
    public var content: String?
    public var schedules: [ItemSchedule]?
    public var mission: MissionItemData?
    
    public init(){}
    
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
        presenter = try values.decodeIfPresent(MissionItemDataPresenter.self, forKey: .presenter)
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
        schedules = try values.decodeIfPresent([ItemSchedule].self, forKey: .schedules)
        mission = try values.decodeIfPresent(MissionItemData.self, forKey: .mission)
    }
    
    public static func == (lhs: MissionData, rhs: MissionData) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Section Mission

public struct MissionItemData: Decodable, Hashable {
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
    
    public static func == (lhs: MissionItemData, rhs: MissionItemData) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Section Schedule

public struct ItemSchedule: Decodable, Hashable {
    public var id: String?
    public var startAt: String?
    public var endAt: String?
    public var missionId: String?
    public var campaignId: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var deletedAt: String?
    public var claim: String?
    
    public init(){}
    
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
    
    public static func == (lhs: ItemSchedule, rhs: ItemSchedule) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Section Presenter

public struct MissionItemDataPresenter: Decodable, Hashable {
    var id = UUID()
    public var label: String?
    
    public init(){}
    
    private enum CodingKeys: String, CodingKey {
        case label
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
    public static func == (lhs: MissionItemDataPresenter, rhs: MissionItemDataPresenter) -> Bool {
        return lhs.id == rhs.id
    }
}
