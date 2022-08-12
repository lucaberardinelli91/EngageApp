//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

struct AnswerDataSource: Decodable {
    let id: String?
    let text: String?
    let correct: Bool?

    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case correct
    }

    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        text = try? values?.decodeIfPresent(String.self, forKey: .text)
        correct = try? values?.decodeIfPresent(Bool.self, forKey: .correct)
    }
}
