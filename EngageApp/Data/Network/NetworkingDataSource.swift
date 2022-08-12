//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Combine
import Networking

// MARK: - NetworkingDataSource

public class NetworkingDataSource: NetworkingDataSourceProtocol {
    private var cancellables = Set<AnyCancellable>()
    var networking: NetworkingProtocol

    public init(networking: NetworkingProtocol) {
        self.networking = networking
    }

    // MARK: - Login

    public func checkEmail(email: String) -> AnyPublisher<CheckEmail, CustomError> {
        return checkEmailAndReturn(email: email)
            .map { checkEmailDataSource in
                CheckEmail(checkEmailDataSource: checkEmailDataSource)
            }
            .eraseToAnyPublisher()
    }

    func checkEmailAndReturn(email: String) -> AnyPublisher<CheckEmailDataSource, CustomError> {
        let emailBody = CheckEmailPost(email: email)
        let body = (data: emailBody, encoding: NetworkingRequest.Encoding.json)
        let request = NetworkingRequest(method: .post, path: ("/external/email-verification", nil), body: body)
        return response(publisher: networking.send(request: request))
    }

    public func checkLoginByOtp(otp: String) -> AnyPublisher<LoginByOtp, CustomError> {
        let request = NetworkingRequest(method: .get, path: ("/external/login/\(otp)", nil))
        return response(publisher: networking.send(request: request))
    }

    // MARK: - Campaign (app info)

    public func getCampaign() -> AnyPublisher<CampaignRoot, CustomError> {
        let request = NetworkingRequest(method: .get, path: ("/campaign/info", nil))
        return response(publisher: networking.send(request: request))
    }

    // MARK: - User info

    public func getUser(campaignId: String) -> AnyPublisher<UserRoot, CustomError> {
        let path = "/campaigns/\(campaignId)/users/info"
        let request = NetworkingRequest(method: .get, path: (path, nil))
        return response(publisher: networking.send(request: request))
    }

    // MARK: - Wallet

    public func getWallet(campaignId: String) -> AnyPublisher<WalletRoot?, CustomError> {
        let path = "/campaigns/\(campaignId)/users/account-balance"
        let request = NetworkingRequest(method: .get, path: (path, nil))
        return response(publisher: networking.send(request: request))
    }

    // MARK: - Quiz

    /// Quiz detail
    public func getDetailQuiz(campaignId: String, quizId: String) -> AnyPublisher<QuizDetail, CustomError> {
        return detailQuiz(campaignId: campaignId, quizId: quizId)
            .map { quizDetailDataSource in
                QuizDetail(quizDetailDataSource: quizDetailDataSource)
            }
            .eraseToAnyPublisher()
    }

    func detailQuiz(campaignId: String, quizId: String) -> AnyPublisher<QuizDetailDataSource, CustomError> {
        let path = "/campaigns/\(campaignId)/instantwins/\(quizId)"
        let request = NetworkingRequest(method: .get, path: (path, nil))
        return response(publisher: networking.send(request: request))
    }

    /// Quiz next question
    public func getNextQuestion(campaignId: String, quizId: String) -> AnyPublisher<Question, CustomError> {
        return nextQuestion(campaignId: campaignId, quizId: quizId)
            .map { questionDataSource in
                Question(questionDataSource: questionDataSource)
            }
            .eraseToAnyPublisher()
    }

    func nextQuestion(campaignId: String, quizId: String) -> AnyPublisher<QuestionDataSource, CustomError> {
        let path = "/campaigns/\(campaignId)/instantwins/\(quizId)/question"
        let request = NetworkingRequest(method: .get, path: (path, nil))
        return response(publisher: networking.send(request: request))
    }

    /// Quiz post answer
    public func postAnswer(campaignId: String, quizId: String, answer: AnswerRequest) -> AnyPublisher<QuizResponse, CustomError> {
        return postAnswerRequest(campaignId: campaignId, quizId: quizId, answer: answer)
            .map { quizResponseDataSource in
                QuizResponse(quizResponseDataSource: quizResponseDataSource)
            }
            .eraseToAnyPublisher()
    }

    func postAnswerRequest(campaignId: String, quizId: String, answer: AnswerRequest) -> AnyPublisher<QuizResponseDataSource, CustomError> {
        let path = "/campaigns/\(campaignId)/instantwins/\(quizId)/answer"
        let body = (data: answer, encoding: NetworkingRequest.Encoding.json)
        let request = NetworkingRequest(method: .post, path: (path, nil), body: body)
        return response(publisher: networking.send(request: request))
    }

    // MARK: - Notifications

    public func getNotifications(campaignId: String) -> AnyPublisher<[Notification]?, CustomError> {
        return notifications(campaignId: campaignId)
            .map(\.?.notifications)
            .map { notificationsRootDataSource in
                notificationsRootDataSource.map { _notificationsRootDataSource in
                    _notificationsRootDataSource.map { notificationDataSource in
                        Notification(notificationDataSource: notificationDataSource)
                    }
                }
            }
            .eraseToAnyPublisher()
    }

    func notifications(campaignId: String) -> AnyPublisher<NotificationsRootDataSource?, CustomError> {
        let request = NetworkingRequest(method: .get, path: ("/campaigns/\(campaignId)/dashboard/information/boxes", nil))
        return response(publisher: networking.send(request: request))
    }

    // MARK: - Catalog

    public func getCatalog(campaignId: String) -> AnyPublisher<Catalog?, CustomError> {
        let request = NetworkingRequest(method: .get, path: ("/campaigns/\(campaignId)/catalog/rewards", nil))
        return response(publisher: networking.send(request: request))
    }

    public func getRewardDetail(campaignId: String, rewardId: String) -> AnyPublisher<Reward?, CustomError> {
        return getRewardDetailAndReturn(campaignId: campaignId, rewardId: rewardId)
            .map { rewardDetailDataSource in
                Reward(rewardDetailDataSource: rewardDetailDataSource)
            }
            .eraseToAnyPublisher()
    }

    func getRewardDetailAndReturn(campaignId: String, rewardId: String) -> AnyPublisher<RewardDataSource, CustomError> {
        let request = NetworkingRequest(method: .get, path: ("/campaigns/\(campaignId)/catalog/rewards/\(rewardId)", nil), body: nil)
        return response(publisher: networking.send(request: request))
    }

    public func redeemReward(campaignId: String, rewardId: String) -> AnyPublisher<EmptyResponse, CustomError> {
        let request = NetworkingRequest(method: .get, path: ("/campaigns/\(campaignId)/catalog/rewards/\(rewardId)/request", nil))
        return response(publisher: networking.send(request: request))
    }

    // MARK: - Missions

    public func getMissions(campaignId: String) -> AnyPublisher<Missions?, CustomError> {
        let request = NetworkingRequest(method: .get, path: ("/campaigns/\(campaignId)/users/tasks", nil))
        return response(publisher: networking.send(request: request))
    }

    // MARK: - Survey

    public func getSurveyQuestions(campaignId: String, surveyId: String) -> AnyPublisher<[SurveyQuestion]?, CustomError> {
        return surveyQuestions(campaignId: campaignId, surveyId: surveyId)
            .map(\.?.questions)
            .map { surveyQuestionsDataSource in
                surveyQuestionsDataSource.map { _surveyQuestionsDataSource in
                    _surveyQuestionsDataSource.map { surveyQuestionDataSource in
                        SurveyQuestion(surveyQuestionDataSource: surveyQuestionDataSource)
                    }
                }
            }
            .eraseToAnyPublisher()
    }

    func surveyQuestions(campaignId: String, surveyId: String) -> AnyPublisher<SurveyQuestionsRootDataSource?, CustomError> {
        let request = NetworkingRequest(method: .get, path: ("/campaigns/\(campaignId)/surveys/\(surveyId)/questions", nil))
        return response(publisher: networking.send(request: request))
    }

    public func surveySend(campaignId: String, surveyId: String, surveyRequest: SurveyPostRequest) -> AnyPublisher<EmptyResponse, CustomError> {
        let path = "/campaigns/\(campaignId)/surveys/\(surveyId)/answers"
        let body = (data: surveyRequest, encoding: NetworkingRequest.Encoding.json)
        let request = NetworkingRequest(method: .post, path: (path, nil), body: body)
        return response(publisher: networking.send(request: request))
    }

    // MARK: - Information

    public func markInformationAsRead(campaignId: String, infoId: String) -> AnyPublisher<EmptyResponse, CustomError> {
        let path = "/campaigns/\(campaignId)/information/\(infoId)"
        let request = NetworkingRequest(method: .post, path: (path, nil), body: nil)
        return response(publisher: networking.send(request: request))
    }

    // MARK: - InstantWin

    public func instantWinPlay(campaignId: String, instantwinRandomId: String) -> AnyPublisher<InstantWin, CustomError> {
        return instantWinPlayAndReturn(campaignId: campaignId, instantwinRandomId: instantwinRandomId)
            .map { instantwinDataSource in
                InstantWin(instantWinDataSource: instantwinDataSource)
            }
            .eraseToAnyPublisher()
    }

    public func instantWinPlayAndReturn(campaignId: String, instantwinRandomId: String) -> AnyPublisher<InstantWinDataSource, CustomError> {
        let path = "/campaigns/\(campaignId)/instantwinsRandom/\(instantwinRandomId)/play"
        let request = NetworkingRequest(method: .post, path: (path, nil), body: nil)
        return response(publisher: networking.send(request: request))
    }

    // MARK: - Fancam

    public func uploadFancam(campaignId: String, uploadId: String, image _: EncodableImage, comment: String) -> AnyPublisher<Bool, CustomError> {
        let body = (data: UploadImageRequest(uploadedContent: AppAsset.imageTest.image.pngData() ?? Data(), comment: comment), encoding: NetworkingRequest.Encoding.json)
        let path = "/campaigns/\(campaignId)/upload/play/\(uploadId)"
        var request = NetworkingRequest(method: .post, path: (path, [URLQueryItem(name: "isMobile", value: "true")]), body: body)
        let boundary = UUID().uuidString
        request.header = ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
        let medias = NetworkingMedia(data: AppAsset.imageTest.image.pngData() ?? Data(), key: "uploadedContent", filename: "uploadedContent.png", mimeType: "image/png")
        return response(publisher: networking.send(request: request, medias: [medias], boundary: boundary))
    }

    // MARK: - Privacy and conditions

    public func updatePrivacyConditions(privacyFlags: PrivacyFlags) -> AnyPublisher<EmptyResponse, CustomError> {
        // TODO:
        let path = "___"
        let body = (data: privacyFlags, encoding: NetworkingRequest.Encoding.json)
        let request = NetworkingRequest(method: .post, path: (path, nil), body: body)
        return response(publisher: networking.send(request: request))
    }
}

private extension NetworkingDataSource {
    func response<SuccessResponse: Decodable>(publisher: AnyPublisher<SuccessResponse, Error>) -> AnyPublisher<SuccessResponse, CustomError> {
        return publisher
            .mapError { error in
                guard case NetworkingError.underlying(response: _, data: let data) = error, let errorData = data else { return CustomError.genericError(error.localizedDescription) }
                return ErrorManager.parseError(data: errorData)
            }
            .eraseToAnyPublisher()
    }

    func createURLQueryItemsString(stringsArray: [String]) -> String {
        return stringsArray.joined(separator: ",").clearBackSlash()
    }
}
