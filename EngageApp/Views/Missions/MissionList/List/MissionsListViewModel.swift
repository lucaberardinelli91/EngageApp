//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol MissionsListViewModelProtocol {
    func getMissions()
}

public class MissionsListViewModel: BaseViewModel, MissionsListViewModelProtocol {
    @Published var getMissionsState: LoadingState<[Mission], CustomError> = .idle
    private let getMissionsUseCase: GetMissionsProtocol
    public var coins: Int?

    public init(getMissionsUseCase: GetMissionsProtocol, coins: Int) {
        self.getMissionsUseCase = getMissionsUseCase
        self.coins = coins
    }

    public func getMissions() {
        getMissionsState = .success(Mission.getMissions())
//        getMissionsState = .loading
//
//        getMissionsUseCase.execute()
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                guard case let .failure(error) = completion else { return }
//                self.getMissionsState = .failure(error)
//            } receiveValue: { [self] missions in
//                guard let missions = missions?.tasks else { return }
//                getMissionsState = .success(missions)
//            }.store(in: &cancellables)
    }
}
