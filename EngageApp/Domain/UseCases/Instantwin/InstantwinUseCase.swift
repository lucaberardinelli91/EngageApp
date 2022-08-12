//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol InstantwinPlayProtocol {
    func execute(instantwinRandomId: String) -> AnyPublisher<InstantWin, CustomError>
}

enum InstantwinUseCase {
    class InstantwinPlay: InstantwinPlayProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var instantwinRepository: InstantwinRepositoryProtocol

        public init(instantwinRepository: InstantwinRepositoryProtocol) {
            self.instantwinRepository = instantwinRepository
        }

        func execute(instantwinRandomId: String) -> AnyPublisher<InstantWin, CustomError> {
            instantwinRepository.instantWinPlay(instantwinRandomId: instantwinRandomId)
        }
    }
}
