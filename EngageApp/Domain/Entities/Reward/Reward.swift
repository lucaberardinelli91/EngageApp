//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct Reward: Decodable, Hashable {
    public var id: String?
    public var image: String?
    public var type: String?
    public var cost: Int?
    public var status: String?
    public var digital: Bool?
    public var max_requests: Int?
    public var limited_availability: Bool?
    public var availability: Int?
    public var campaign_id: String?
    public var created_at: String?
    public var updated_at: String?
    public var deleted_at: String?
    public var redeem_count_for_reward: Int?
    public var title: String?
    public var description: String?
    public var email: String?
    public var redeemable: Bool?
    public var redeems: Int?
    public var user_redeems: Int?
    public var at_level: String?

    init(rewardDetailDataSource: RewardDataSource) {
        id = rewardDetailDataSource.id
        image = rewardDetailDataSource.image
        type = rewardDetailDataSource.type
        cost = rewardDetailDataSource.cost
        status = rewardDetailDataSource.status
        digital = rewardDetailDataSource.digital
        max_requests = rewardDetailDataSource.max_requests
        limited_availability = rewardDetailDataSource.limited_availability
        availability = rewardDetailDataSource.availability
        campaign_id = rewardDetailDataSource.campaign_id
        created_at = rewardDetailDataSource.created_at
        updated_at = rewardDetailDataSource.updated_at
        deleted_at = rewardDetailDataSource.deleted_at
        redeem_count_for_reward = rewardDetailDataSource.redeem_count_for_reward
        title = rewardDetailDataSource.title
        description = rewardDetailDataSource.description
        email = rewardDetailDataSource.email
        redeemable = rewardDetailDataSource.redeemable
        redeems = rewardDetailDataSource.redeems
        user_redeems = rewardDetailDataSource.user_redeems
        at_level = rewardDetailDataSource.at_level
    }

    
    static func getRewards() -> [Reward] {
        return [Reward(1),
                Reward(2),
                Reward(3),
                Reward(4),
                Reward(5),
                Reward(6),
                Reward(7),
                Reward(8)]
    }
    
    public init(_ count: Int) {
        switch count {
        case 1:
            self.id = "1"
            self.image = "https://fanize.s3-eu-west-1.amazonaws.com/assets/campaigns/rewards/reward_e729dbc0-117c-11ed-9d17-9122646de73e_1659346367.jpeg"
            self.type = "coins"
            self.cost = 150
            self.status = "available"
            self.digital = false
            self.max_requests = 5000
            self.limited_availability = false
            self.availability = 0
            self.campaign_id = "bc4fec10-e744-11ec-affa-1329312dd338"
            self.created_at = "2022-08-01 09:32:47"
            self.updated_at = "2022-08-01 09:32:47"
            self.deleted_at = ""
            self.redeem_count_for_reward = 2
            self.title = "INGRESSO SPA PER 2 PERSONE"
            self.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
            self.email = ""
            self.redeemable = true
            self.redeems = 0
            self.user_redeems = 2
            self.at_level = ""
        case 2:
            self.id = "2"
            self.image = "https://fanize.s3-eu-west-1.amazonaws.com/assets/campaigns/rewards/reward_e729dbc0-117c-11ed-9d17-9122646de73e_1659346367.jpeg"
            self.type = "coins"
            self.cost = 100
            self.status = "available"
            self.digital = false
            self.max_requests = 5000
            self.limited_availability = false
            self.availability = 0
            self.campaign_id = "bc4fec10-e744-11ec-affa-1329312dd338"
            self.created_at = "2022-08-01 09:32:47"
            self.updated_at = "2022-08-01 09:32:47"
            self.deleted_at = ""
            self.redeem_count_for_reward = 2
            self.title = "UNA NOTTE IN CAMERA SUITE"
            self.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
            self.email = ""
            self.redeemable = true
            self.redeems = 0
            self.user_redeems = 2
            self.at_level = ""
        case 3:
            self.id = "3"
            self.image = "https://fanize.s3-eu-west-1.amazonaws.com/assets/campaigns/rewards/reward_e729dbc0-117c-11ed-9d17-9122646de73e_1659346367.jpeg"
            self.type = "coins"
            self.cost = 50
            self.status = "available"
            self.digital = false
            self.max_requests = 5000
            self.limited_availability = false
            self.availability = 0
            self.campaign_id = "bc4fec10-e744-11ec-affa-1329312dd338"
            self.created_at = "2022-08-01 09:32:47"
            self.updated_at = "2022-08-01 09:32:47"
            self.deleted_at = ""
            self.redeem_count_for_reward = 2
            self.title = "CENA AL RISTORANTE ALL INCLUSIVE"
            self.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
            self.email = ""
            self.redeemable = true
            self.redeems = 0
            self.user_redeems = 2
            self.at_level = ""
        case 4:
            self.id = "4"
            self.image = "https://fanize.s3-eu-west-1.amazonaws.com/assets/campaigns/rewards/reward_e729dbc0-117c-11ed-9d17-9122646de73e_1659346367.jpeg"
            self.type = "coins"
            self.cost = 300
            self.status = "available"
            self.digital = false
            self.max_requests = 5000
            self.limited_availability = false
            self.availability = 0
            self.campaign_id = "bc4fec10-e744-11ec-affa-1329312dd338"
            self.created_at = "2022-08-01 09:32:47"
            self.updated_at = "2022-08-01 09:32:47"
            self.deleted_at = ""
            self.redeem_count_for_reward = 2
            self.title = "DUE BIGLIETTI PER IL TEATRO"
            self.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
            self.email = ""
            self.redeemable = true
            self.redeems = 0
            self.user_redeems = 2
            self.at_level = ""
        case 5:
            self.id = "5"
            self.image = "https://fanize.s3-eu-west-1.amazonaws.com/assets/campaigns/rewards/reward_e729dbc0-117c-11ed-9d17-9122646de73e_1659346367.jpeg"
            self.type = "coins"
            self.cost = 500
            self.status = "available"
            self.digital = false
            self.max_requests = 5000
            self.limited_availability = false
            self.availability = 0
            self.campaign_id = "bc4fec10-e744-11ec-affa-1329312dd338"
            self.created_at = "2022-08-01 09:32:47"
            self.updated_at = "2022-08-01 09:32:47"
            self.deleted_at = ""
            self.redeem_count_for_reward = 2
            self.title = "ESCURSIONE GUIDATA TUTTO IL GIORNO"
            self.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
            self.email = ""
            self.redeemable = true
            self.redeems = 0
            self.user_redeems = 2
            self.at_level = ""
        case 6:
            self.id = "6"
            self.image = "https://fanize.s3-eu-west-1.amazonaws.com/assets/campaigns/rewards/reward_e729dbc0-117c-11ed-9d17-9122646de73e_1659346367.jpeg"
            self.type = "coins"
            self.cost = 350
            self.status = "available"
            self.digital = false
            self.max_requests = 5000
            self.limited_availability = false
            self.availability = 0
            self.campaign_id = "bc4fec10-e744-11ec-affa-1329312dd338"
            self.created_at = "2022-08-01 09:32:47"
            self.updated_at = "2022-08-01 09:32:47"
            self.deleted_at = ""
            self.redeem_count_for_reward = 2
            self.title = "GITA IN BARCA CON CHAMPAGNE"
            self.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
            self.email = ""
            self.redeemable = true
            self.redeems = 0
            self.user_redeems = 2
            self.at_level = ""
        case 7:
            self.id = "7"
            self.image = "https://fanize.s3-eu-west-1.amazonaws.com/assets/campaigns/rewards/reward_e729dbc0-117c-11ed-9d17-9122646de73e_1659346367.jpeg"
            self.type = "coins"
            self.cost = 600
            self.status = "available"
            self.digital = false
            self.max_requests = 5000
            self.limited_availability = false
            self.availability = 0
            self.campaign_id = "bc4fec10-e744-11ec-affa-1329312dd338"
            self.created_at = "2022-08-01 09:32:47"
            self.updated_at = "2022-08-01 09:32:47"
            self.deleted_at = ""
            self.redeem_count_for_reward = 2
            self.title = "ESCURSIONE GUIDATA TUTTO IL GIORNO"
            self.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
            self.email = ""
            self.redeemable = true
            self.redeems = 0
            self.user_redeems = 2
            self.at_level = ""
        case 8:
            self.id = "8"
            self.image = "https://fanize.s3-eu-west-1.amazonaws.com/assets/campaigns/rewards/reward_e729dbc0-117c-11ed-9d17-9122646de73e_1659346367.jpeg"
            self.type = "coins"
            self.cost = 450
            self.status = "available"
            self.digital = false
            self.max_requests = 5000
            self.limited_availability = false
            self.availability = 0
            self.campaign_id = "bc4fec10-e744-11ec-affa-1329312dd338"
            self.created_at = "2022-08-01 09:32:47"
            self.updated_at = "2022-08-01 09:32:47"
            self.deleted_at = ""
            self.redeem_count_for_reward = 2
            self.title = "CENA AL RISTORANTE ALL INCLUSIVE"
            self.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
            self.email = ""
            self.redeemable = true
            self.redeems = 0
            self.user_redeems = 2
            self.at_level = ""
        default: break
        }
    }
    
    public static func == (lhs: Reward, rhs: Reward) -> Bool {
        return lhs.id == rhs.id
    }
}
