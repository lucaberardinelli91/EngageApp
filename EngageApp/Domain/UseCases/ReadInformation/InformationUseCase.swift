//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol MarkInformationAsReadProtocol {
    func execute(infoId: String) -> AnyPublisher<EmptyResponse, CustomError>
}

enum InformationUseCase {
    class MarkInformationAsRead: MarkInformationAsReadProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var informationRepository: InformationRepositoryProtocol

        public init(informationRepository: InformationRepositoryProtocol) {
            self.informationRepository = informationRepository
        }

        func execute(infoId: String) -> AnyPublisher<EmptyResponse, CustomError> {
            informationRepository.markInformationAsRead(infoId: infoId)
        }
    }
}
