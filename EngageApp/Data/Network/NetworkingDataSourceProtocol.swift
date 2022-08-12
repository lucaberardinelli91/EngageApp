//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Combine

public protocol NetworkingDataSourceProtocol {
    /// Login
    func checkEmail(email: String) -> AnyPublisher<CheckEmail, CustomError>
    func checkLoginByOtp(otp: String) -> AnyPublisher<LoginByOtp, CustomError>

    /// Campaign (app info)
    func getCampaign() -> AnyPublisher<CampaignRoot, CustomError>

    /// User info
    func getUser(campaignId: String) -> AnyPublisher<UserRoot, CustomError>

    /// Wallet
    func getWallet(campaignId: String) -> AnyPublisher<WalletRoot?, CustomError>

    /// Quiz
    func getDetailQuiz(campaignId: String, quizId: String) -> AnyPublisher<QuizDetail, CustomError>
    func getNextQuestion(campaignId: String, quizId: String) -> AnyPublisher<Question, CustomError>
    func postAnswer(campaignId: String, quizId: String, answer: AnswerRequest) -> AnyPublisher<QuizResponse, CustomError>

    /// Notifications
    func getNotifications(campaignId: String) -> AnyPublisher<[Notification]?, CustomError>

    /// Catalog
    func getCatalog(campaignId: String) -> AnyPublisher<Catalog?, CustomError>
    func getRewardDetail(campaignId: String, rewardId: String) -> AnyPublisher<Reward?, CustomError>
    func redeemReward(campaignId: String, rewardId: String) -> AnyPublisher<EmptyResponse, CustomError>

    /// Missions
    func getMissions(campaignId: String) -> AnyPublisher<Missions?, CustomError>

    /// Survey
    func getSurveyQuestions(campaignId: String, surveyId: String) -> AnyPublisher<[SurveyQuestion]?, CustomError>
    func surveySend(campaignId: String, surveyId: String, surveyRequest: SurveyPostRequest) -> AnyPublisher<EmptyResponse, CustomError>

    /// Information
    func markInformationAsRead(campaignId: String, infoId: String) -> AnyPublisher<EmptyResponse, CustomError>

    /// InstantWin
    func instantWinPlay(campaignId: String, instantwinRandomId: String) -> AnyPublisher<InstantWin, CustomError>

    /// Fancam
    func uploadFancam(campaignId: String, uploadId: String, image: EncodableImage, comment: String) -> AnyPublisher<Bool, CustomError>

    /// Privacy and conditions
    func updatePrivacyConditions(privacyFlags: PrivacyFlags) -> AnyPublisher<EmptyResponse, CustomError>
}
