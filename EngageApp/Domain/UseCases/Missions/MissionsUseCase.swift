//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol GetMissionsProtocol {
    func execute() -> AnyPublisher<Missions?, CustomError>
}

enum MissionsUseCase {
    class GetMissions: GetMissionsProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var missionsRepository: MissionsRepositoryProtocol

        public init(missionsRepository: MissionsRepositoryProtocol) {
            self.missionsRepository = missionsRepository
        }

        func execute() -> AnyPublisher<Missions?, CustomError> {
            missionsRepository.getMissions()
        }
    }
}
