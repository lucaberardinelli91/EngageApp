//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol GetUserProtocol {
    func execute() -> AnyPublisher<UserRoot, CustomError>
}

public protocol GetUserLocalProtocol {
    func execute() -> AnyPublisher<UserInfo?, CustomError>
}

public protocol SaveUserLocalProtocol {
    func execute(user: UserInfo) -> AnyPublisher<Bool, CustomError>
}

public protocol UpdatePrivacyConditionsProtocol {
    func execute(privacyFlags: PrivacyFlags) -> AnyPublisher<EmptyResponse, CustomError>
}

public protocol DeleteAccessTokenProtocol {
    func execute() -> AnyPublisher<Void, CustomError>
}

enum ProfileUseCase {
    class GetUser: GetUserProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var profileRepository: ProfileRepositoryProtocol

        public init(profileRepository: ProfileRepositoryProtocol) {
            self.profileRepository = profileRepository
        }

        func execute() -> AnyPublisher<UserRoot, CustomError> {
            profileRepository.getUser()
        }
    }
    
    class GetUserLocal: GetUserLocalProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var profileRepository: ProfileRepositoryProtocol

        public init(profileRepository: ProfileRepositoryProtocol) {
            self.profileRepository = profileRepository
        }

        func execute() -> AnyPublisher<UserInfo?, CustomError> {
            return profileRepository.getUserLocal()
        }
    }
    
    class SaveUserLocal: SaveUserLocalProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var profileRepository: ProfileRepositoryProtocol

        public init(profileRepository: ProfileRepositoryProtocol) {
            self.profileRepository = profileRepository
        }

        func execute(user: UserInfo) -> AnyPublisher<Bool, CustomError> {
            return profileRepository.saveUserLocal(user: user)
        }
    }

    class UpdatePrivacyConditions: UpdatePrivacyConditionsProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var profileRepository: ProfileRepositoryProtocol

        public init(profileRepository: ProfileRepositoryProtocol) {
            self.profileRepository = profileRepository
        }

        func execute(privacyFlags: PrivacyFlags) -> AnyPublisher<EmptyResponse, CustomError> {
            return profileRepository.updatePrivacyConditions(privacyFlags: privacyFlags)
        }
    }

    class DeleteAccesToken: DeleteAccessTokenProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var profileRepository: ProfileRepositoryProtocol

        public init(profileRepository: ProfileRepositoryProtocol) {
            self.profileRepository = profileRepository
        }

        func execute() -> AnyPublisher<Void, CustomError> {
            return profileRepository.deleteAccessToken()
        }
    }
}
