//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct SurveyAnswerDataSourceModel: Decodable {
    let id: String?
    let text: String?
    let percentage: Float?
    let image: String?

    private enum CodingKeys: String, CodingKey {
        case text
        case percentage
        case id
        case image
    }

    public init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        text = try? values?.decodeIfPresent(String.self, forKey: .text)
        percentage = try? values?.decodeIfPresent(Float.self, forKey: .percentage)
        image = try? values?.decodeIfPresent(String.self, forKey: .image)
    }
}
