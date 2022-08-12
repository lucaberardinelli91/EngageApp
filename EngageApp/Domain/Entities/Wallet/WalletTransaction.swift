//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct WalletTransaction: Decodable, Hashable {
    public var type: String?
    public var title: String?
    public var coins: Int?
    public var created_at: String?

    public init(walletTransactionDataSource: WalletTransactionDataSource) {
        type = walletTransactionDataSource.type
        title = walletTransactionDataSource.title
        coins = walletTransactionDataSource.coins
        created_at = walletTransactionDataSource.created_at
    }

    public static func == (lhs: WalletTransaction, rhs: WalletTransaction) -> Bool {
        return lhs.type == rhs.type
    }
    
    static func getTransactions() -> [WalletTransaction] {
        return [WalletTransaction(13),
                WalletTransaction(12),
                WalletTransaction(1),
                WalletTransaction(2),
                WalletTransaction(3),
                WalletTransaction(11),
                WalletTransaction(4),
                WalletTransaction(5),
                WalletTransaction(10),
                WalletTransaction(9),
                WalletTransaction(8),
                WalletTransaction(7),
                WalletTransaction(6),
                WalletTransaction(13),
                WalletTransaction(12),
                WalletTransaction(11)]
    }
    
    public init(_ count: Int) {
        switch count {
        case 1:
            self.type = "reward.redeem"
            self.coins = -10
            self.created_at = "2022-08-12 09:29:10"
        case 2:
            self.type = "reward.redeem"
            self.coins = -100
            self.created_at = "2022-08-14 19:20:10"
        case 3:
            self.type = "reward.redeem"
            self.coins = -20
            self.created_at = "2022-01-12 02:15:10"
        case 4:
            self.type = "reward.redeem"
            self.coins = -30
            self.created_at = "2022-02-12 20:50:10"
        case 5:
            self.type = "reward.redeem"
            self.coins = -1000
            self.created_at = "2022-05-12 11:45:10"
        case 6:
            self.type = "reward.redeem"
            self.coins = -900
            self.created_at = "2022-08-12 09:29:10"
        case 7:
            self.type = "reward.redeem"
            self.coins = -555
            self.created_at = "2022-08-12 09:29:10"
        case 8:
            self.type = "reward.redeem"
            self.coins = -250
            self.created_at = "2022-08-12 09:29:10"
        case 9:
            self.type = "reward.redeem"
            self.coins = -800
            self.created_at = "2022-08-12 09:29:10"
        case 10:
            self.type = "reward.redeem"
            self.coins = -150
            self.created_at = "2022-08-12 09:29:10"
        case 10:
            self.type = "information.read"
            self.title = "Scopri le ultime novita!"
            self.coins = 150
            self.created_at = "2022-08-12 09:29:10"
        case 11:
            self.type = "instantwin.random"
            self.title = "Tenta la fortuna!"
            self.coins = 350
            self.created_at = "2022-08-12 09:29:10"
        case 12:
            self.type = "instantwin.random"
            self.title = "Gioca ora!"
            self.coins = 550
            self.created_at = "2022-08-12 09:29:10"
        case 13:
            self.type = "instantwin.random"
            self.title = "E' il tuo giorno fortunato?"
            self.coins = 120
            self.created_at = "2022-08-12 09:29:10"
        case 14:
            self.type = "answer.instantwin"
            self.title = "Gioca al quiz!"
            self.coins = 900
            self.created_at = "2022-08-12 09:29:10"
        case 15:
            self.type = "answer.instantwin"
            self.title = "Mettiti alla prova"
            self.coins = 400
            self.created_at = "2022-08-12 09:29:10"
        default: break
        }
    }
}
