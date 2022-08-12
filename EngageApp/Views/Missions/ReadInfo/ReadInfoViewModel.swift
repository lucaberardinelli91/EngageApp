//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol ReadInfoViewModelProtocol {
    func markInformationAsRead(infoId: String)
}

public class ReadInfoViewModel: BaseViewModel, ReadInfoViewModelProtocol {
    @Published var markInformationAsReadState: LoadingState<Void, CustomError> = .idle
    private let markInformationAsReadUseCase: MarkInformationAsReadProtocol

    public init(markInformationAsReadUseCase: MarkInformationAsReadProtocol) {
        self.markInformationAsReadUseCase = markInformationAsReadUseCase
    }

    public func markInformationAsRead(infoId: String) {
        // MOCK API
        markInformationAsReadState = .success(())
        
//        markInformationAsReadState = .loading
//
//        markInformationAsReadUseCase.execute(infoId: infoId)
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                guard case let .failure(error) = completion else { return }
//                self.markInformationAsReadState = .failure(error)
//            } receiveValue: { [self] _ in
//                markInformationAsReadState = .success(())
//            }.store(in: &cancellables)
    }
}
