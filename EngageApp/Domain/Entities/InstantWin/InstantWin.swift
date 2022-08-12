//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

// MARK: - InstantWin

public struct InstantWin {
    public let won: Bool

    init(instantWinDataSource: InstantWinDataSource) {
        won = instantWinDataSource.won
    }
    
    public init(){
        self.won = true
    }
}
