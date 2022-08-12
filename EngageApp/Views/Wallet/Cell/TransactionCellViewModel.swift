//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol TransactionCellViewModelProtocol {
    func getInfo()
}

public class TransactionCellViewModel: TransactionCellViewModelProtocol {
    private var transaction: WalletTransaction

    @Published var transactionCollectionViewCellState: LoadingState<WalletTransaction, CustomError> = .idle

    public init(configurator: WalletTransaction) {
        transaction = configurator
    }

    public func getInfo() {
        transactionCollectionViewCellState = .success(transaction)
    }
}
