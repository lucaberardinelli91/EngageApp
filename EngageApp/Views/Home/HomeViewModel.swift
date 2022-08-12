//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol HomeViewModelProtocol {
    func getCampaignId()
    func getCampaign()
    func saveCampaignId(id: String)
    func getUser()
    func getUserLocal()
    func saveUserLocal()
    func shareFeedback()
}

public class HomeViewModel: BaseViewModel, HomeViewModelProtocol {
    /// Campaign
    private let getCampaigIdUseCase: GetCampaignIdProtocol
    private let getCampaignUseCase: GetCampaignProtocol
    private let saveCampaignIdUseCase: SaveCampaignIdProtocol
    /// User info
    private let getUserUseCase: GetUserProtocol
    private let getUserLocalUseCase: GetUserLocalProtocol
    private let saveUserLocalUseCase: SaveUserLocalProtocol
    private let shareUseCase: ShareProtocol

    @Published var getCampaignIdState: LoadingState<String, CustomError> = .idle
    @Published var getCampaignState: LoadingState<Campaign, CustomError> = .idle
    @Published var saveCampaignIdState: LoadingState<Bool, CustomError> = .idle
    @Published var getUserState: LoadingState<UserInfo, CustomError> = .idle
    @Published var getUserLocalState: LoadingState<UserInfo, CustomError> = .idle
    @Published var saveUserLocalState: LoadingState<Bool, CustomError> = .idle
    @Published var shareState: LoadingState<Void, CustomError> = .idle

    var campaignId: String?
    var userInfo: UserInfo?

    init(getCampaignUseCase: GetCampaignProtocol, saveCampaignIdUseCase: SaveCampaignIdProtocol, shareUseCase: ShareProtocol, getCampaigIdUseCase: GetCampaignIdProtocol, getUserUseCase: GetUserProtocol, saveUserLocalUseCase: SaveUserLocalProtocol, getUserLocalUseCase: GetUserLocalProtocol) {
        self.getCampaigIdUseCase = getCampaigIdUseCase
        self.getCampaignUseCase = getCampaignUseCase
        self.saveCampaignIdUseCase = saveCampaignIdUseCase
        self.getUserUseCase = getUserUseCase
        self.saveUserLocalUseCase = saveUserLocalUseCase
        self.getUserLocalUseCase = getUserLocalUseCase
        self.shareUseCase = shareUseCase
    }

    // MARK: - Campaign

    public func getCampaignId() {
        getCampaignIdState = .loading

        getCampaigIdUseCase.execute()
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.getCampaignIdState = .failure(error)
            } receiveValue: { [self] campaignId in
                self.campaignId = campaignId
                getCampaignIdState = .success(campaignId)
            }.store(in: &cancellables)
    }

    public func getCampaign() {
        getCampaignState = .loading

        getCampaignUseCase.execute()
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.getCampaignState = .failure(error)
            } receiveValue: { [self] data in
                getCampaignState = .success(data.campaign)
            }.store(in: &cancellables)
    }

    public func saveCampaignId(id: String) {
        saveCampaignIdState = .loading

        saveCampaignIdUseCase.execute(id: id)
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.saveCampaignIdState = .failure(error)
            } receiveValue: { [self] _ in
                self.saveCampaignIdState = .success(true)
            }.store(in: &cancellables)
    }

    // MARK: - User info

    /// Get user from api
    public func getUser() {
        getUserState = .loading

        getUserUseCase.execute()
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.getUserState = .failure(error)
            } receiveValue: { [self] data in
                self.userInfo = data.user
                getUserState = .success(data.user)
            }.store(in: &cancellables)
    }

    /// Save user info on device
    public func saveUserLocal() {
        guard let userInfo = userInfo else { return }

        saveUserLocalState = .loading

        saveUserLocalUseCase.execute(user: userInfo)
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.saveUserLocalState = .failure(error)
            } receiveValue: { [self] _ in
                saveUserLocalState = .success(true)
            }.store(in: &cancellables)
    }

    /// Get user info from device
    public func getUserLocal() {
        getUserLocalState = .loading

        getUserLocalUseCase.execute()
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.getUserLocalState = .failure(error)
            } receiveValue: { [self] user in
                guard let user = user else {
                    self.getUserLocalState = .failure(CustomError.genericError("User not found locally"))
                    return
                }
                getUserLocalState = .success(user)
            }.store(in: &cancellables)
    }

    // MARK: Mission feedback

    public func shareFeedback() {
        shareState = .loading

        shareUseCase.execute(shareHelper: ShareHelper.shared, title: nil, url: nil)
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.shareState = .failure(CustomError.genericError("Share error"))
            } receiveValue: { [self] _ in
                self.shareState = .success(())
            }.store(in: &cancellables)
    }
}
