//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol MissionCellViewModelProtocol {
    func getInfo()
}

public class MissionCellViewModel: MissionCellViewModelProtocol {
    private var mission: Mission

    @Published var missionCollectionViewCellState: LoadingState<Mission, CustomError> = .idle

    public init(configurator: Mission) {
        mission = configurator
    }

    public func getInfo() {
        missionCollectionViewCellState = .success(mission)
    }
}
