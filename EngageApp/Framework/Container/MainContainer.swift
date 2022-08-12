//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

/// In this container we must register and initialize all repository
class MainContainer: MainContainerProtocol {
    // MARK: - Data Source

    private var networking = NetworkingManager()
    private var localStorage = LocalStorageManager()

    // MARK: - Repositories

    private var authRepository: AuthRepositoryProtocol
    private var campaignRepository: CampaignRepositoryProtocol
    private var notificationsRepository: NotificationsRepositoryProtocol
    private var catalogRepository: CatalogRepositoryProtocol
    private var missionsRepository: MissionsRepositoryProtocol
    private var fanCamRepository: FanCamRepositoryProtocol
    private var quizRepository: QuizRepositoryProtocol
    private var surveyRepository: SurveyRepositoryProtocol
    private var informationRepository: InformationRepositoryProtocol
    private var instantwinRepository: InstantwinRepositoryProtocol
    private var profileRepository: ProfileRepositoryProtocol
    private var walletRepository: WalletRepositoryProtocol

    // MARK: - UseCases

    /// Auth
    public var checkEmail: CheckEmailProtocol
    public var checkLoginByOtp: CheckLoginByOtpProtocol
    public var saveAccessToken: SaveAccessTokenProtocol
    public var getAccessToken: GetAccessTokenProtocol

    /// Profile
    public var getUser: GetUserProtocol
    public var getUserLocal: GetUserLocalProtocol
    public var saveUserLocal: SaveUserLocalProtocol
    public var deleteAccessToken: DeleteAccessTokenProtocol
    public var updatePrivacyConditions: UpdatePrivacyConditionsProtocol

    /// Campaign (app info)
    public var getCampaign: GetCampaignProtocol
    public var saveCampaignId: SaveCampaignIdProtocol
    public var getCampaignId: GetCampaignIdProtocol
    public var redeemReward: RedeemRewardProtocol

    /// Wallet
    public var getWallet: GetWalletProtocol

    /// Notifications
    public var getNotifications: GetNotificationsProtocol

    /// Catalog
    public var getCatalog: GetCatalogProtocol
    public var getRewardDetail: GetRewardDetailProtocol

    /// Missions
    public var getMissions: GetMissionsProtocol

    /// Survey
    public var getSurveyQuestions: GetSurveyQuestionsProtocol
    public var sendSurveyQuestions: SendSurveyQuestionsProtocol

    /// FanCam
    public var saveFancamPhoto: SaveFancamPhotoProtocol
    public var getFancamPhoto: GetFancamPhotoProtocol
    public var uploadFancamPhoto: UploadFancamPhotoProtocol

    /// Quiz
    var getQuizDetail: GetQuizDetailProtocol
    var getNextQuestion: GetNextQuestionProtocol
    var postAnswer: PostAnswerProtocol

    /// Information
    var markInformationAsRead: MarkInformationAsReadProtocol

    /// Instantwin
    var instantwinPlay: InstantwinPlayProtocol

    /// App Helper
    var share: ShareProtocol
    var validation: ValidateProtocol

    public init() {
        // MARK: - Repository

        /// Repository
        authRepository = AuthRepository(localStorageWorker: localStorage.user, networkWorker: networking.networkingDataSource)
        campaignRepository = CampaignRepository(networkWorker: networking.networkingDataSource, localStorageWorker: localStorage.user)
        notificationsRepository = NotificationsRepository(networkWorker: networking.networkingDataSource, localStorageWorker: localStorage.user)
        catalogRepository = CatalogRepository(networkWorker: networking.networkingDataSource, localStorageWorker: localStorage.user)
        missionsRepository = MissionsRepository(networkWorker: networking.networkingDataSource, localStorageWorker: localStorage.user)
        fanCamRepository = FanCamRepository(networkingWorker: networking.networkingDataSource, localStorageWorker: localStorage.user)
        quizRepository = QuizRepository(networkingWorker: networking.networkingDataSource, localStorageWorker: localStorage.user)
        surveyRepository = SurveyRepository(networkingWorker: networking.networkingDataSource, localStorageWorker: localStorage.user)
        informationRepository = InformationRepository(networkWorker: networking.networkingDataSource, localStorageWorker: localStorage.user)
        instantwinRepository = InstantwinRepository(networkWorker: networking.networkingDataSource, localStorageWorker: localStorage.user)
        profileRepository = ProfileRepository(networkWorker: networking.networkingDataSource, localStorageWorker: localStorage.user)
        walletRepository = WalletRepository(networkWorker: networking.networkingDataSource, localStorageWorker: localStorage.user)

        // MARK: - UseCase

        /// Auth
        checkEmail = AuthUseCase.CheckEmailRegistration(authRepository: authRepository)
        checkLoginByOtp = AuthUseCase.CheckLoginByOtp(authRepository: authRepository)
        saveAccessToken = AuthUseCase.SaveAccessTokenKeychain(authRepository: authRepository)
        getAccessToken = AuthUseCase.GetAccessTokenKeychain(authRepository: authRepository)
        
        /// Profile
        getUser = ProfileUseCase.GetUser(profileRepository: profileRepository)
        getUserLocal = ProfileUseCase.GetUserLocal(profileRepository: profileRepository)
        saveUserLocal = ProfileUseCase.SaveUserLocal(profileRepository: profileRepository)
        deleteAccessToken = ProfileUseCase.DeleteAccesToken(profileRepository: profileRepository)
        updatePrivacyConditions = ProfileUseCase.UpdatePrivacyConditions(profileRepository: profileRepository)

        /// Campaign (app info)
        getCampaign = CampaignUseCase.GetCampaign(campaignRepository: campaignRepository)
        saveCampaignId = CampaignUseCase.SaveCampaignId(campaignRepository: campaignRepository)
        getCampaignId = CampaignUseCase.GetCampaignId(campaignRepository: campaignRepository)

        /// Wallet
        getWallet = WalletUseCase.GetWallet(walletRepository: walletRepository)

        /// Notifications
        getNotifications = NotificationsUseCase.GetNotifications(notificationsRepository: notificationsRepository)

        /// Catalog
        getCatalog = CatalogUseCase.GetCatalog(catalogRepository: catalogRepository)
        getRewardDetail = CatalogUseCase.GetRewardDetail(catalogRepository: catalogRepository)
        redeemReward = CatalogUseCase.RedeemReward(catalogRepository: catalogRepository)

        /// Missions list
        getMissions = MissionsUseCase.GetMissions(missionsRepository: missionsRepository)

        /// Survey
        getSurveyQuestions = SurveyUseCase.GetSurveyQuestions(surveyRepository: surveyRepository)
        sendSurveyQuestions = SurveyUseCase.SendSurveyQuestions(surveyRepository: surveyRepository)

        /// FanCam
        saveFancamPhoto = CameraUseCase.SaveCapturedPhoto(fanCamRepository: fanCamRepository)
        getFancamPhoto = CameraUseCase.GetCapturedPhoto(fanCamRepository: fanCamRepository)
        uploadFancamPhoto = CameraUseCase.UploadFancamPhoto(fanCamRepository: fanCamRepository)

        /// Quiz
        getQuizDetail = QuizUseCase.GetQuizDetail(quizRepository: quizRepository)
        getNextQuestion = QuizUseCase.NextQuestion(quizRepository: quizRepository)
        postAnswer = QuizUseCase.PostAnswer(quizRepository: quizRepository)

        /// App Helper
        share = AppHelperUseCase.Share()
        validation = AppHelperUseCase.Validation()

        /// Information
        markInformationAsRead = InformationUseCase.MarkInformationAsRead(informationRepository: informationRepository)

        /// Instantwin
        instantwinPlay = InstantwinUseCase.InstantwinPlay(instantwinRepository: instantwinRepository)
    }
}
