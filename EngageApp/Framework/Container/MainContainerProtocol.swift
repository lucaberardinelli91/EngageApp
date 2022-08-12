//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol MainContainerProtocol {
    /// Auth
    var checkEmail: CheckEmailProtocol { get set }
    var checkLoginByOtp: CheckLoginByOtpProtocol { get set }
    var saveAccessToken: SaveAccessTokenProtocol { get set }
    var getAccessToken: GetAccessTokenProtocol { get set }

    /// Profile
    var getUser: GetUserProtocol { get set }
    var getUserLocal: GetUserLocalProtocol { get set }
    var saveUserLocal: SaveUserLocalProtocol { get set }
    var deleteAccessToken: DeleteAccessTokenProtocol { get set }
    var updatePrivacyConditions: UpdatePrivacyConditionsProtocol { get set }

    /// Campaign (app info)
    var getCampaign: GetCampaignProtocol { get set }
    var saveCampaignId: SaveCampaignIdProtocol { get set }
    var getCampaignId: GetCampaignIdProtocol { get set }
    var redeemReward: RedeemRewardProtocol { get set }

    /// Wallet
    var getWallet: GetWalletProtocol { get set }

    /// Notifications
    var getNotifications: GetNotificationsProtocol { get set }

    /// Catalog
    var getCatalog: GetCatalogProtocol { get set }
    var getRewardDetail: GetRewardDetailProtocol { get set }

    /// Missions
    var getMissions: GetMissionsProtocol { get set }

    /// Survey
    var getSurveyQuestions: GetSurveyQuestionsProtocol { get set }
    var sendSurveyQuestions: SendSurveyQuestionsProtocol { get set }

    /// FanCam
    var saveFancamPhoto: SaveFancamPhotoProtocol { get set }
    var getFancamPhoto: GetFancamPhotoProtocol { get set }
    var uploadFancamPhoto: UploadFancamPhotoProtocol { get set }

    /// Quiz
    var getQuizDetail: GetQuizDetailProtocol { get set }
    var getNextQuestion: GetNextQuestionProtocol { get set }
    var postAnswer: PostAnswerProtocol { get set }

    /// Information
    var markInformationAsRead: MarkInformationAsReadProtocol { get set }

    /// Instantwin
    var instantwinPlay: InstantwinPlayProtocol { get set }

    /// Helper
    var share: ShareProtocol { get set }
    var validation: ValidateProtocol { get set }
}
