//
//
//  NotificationDataSourceModel.swift
//
//  Created on 16/06/22
//  Copyright © 2022 IQUII s.r.l. All rights reserved.
//

import Foundation

public struct NotificationDataSourceModel: Decodable {
    var id: Int?
    let title: String?
    let description: String?

    private enum CodingKeys: String, CodingKey {
        // TODO:
        case id
        case title
        case description
    }

    public init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int.self, forKey: .id)
        title = try? values?.decodeIfPresent(String.self, forKey: .title)
        description = try? values?.decodeIfPresent(String.self, forKey: .description)
    }
}
