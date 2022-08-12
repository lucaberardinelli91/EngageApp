//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

// MARK: - BaseError

public enum CustomError: Swift.Error, Equatable {
    case authEmailNotConfirmed
    case maintenanceMode
    case obsoleteVersion
    case bannedUser
    case genericError(String?)
    case authMissingAgreement
    case quizTimeout
    case authUnauthorized(String?)
    case userIsNotLoggedIn
    case resourceNotFound
    case cameraPermissionDenied
    case isFirstTimeToOpenApp
}

// MARK: LocalizedError

extension CustomError: LocalizedError {
    /// We must override `errorDescription` to access `error.localizedDescription`
    public var errorDescription: String? {
        switch self {
        case let .genericError(errorMessage):
            return errorMessage
        case .authEmailNotConfirmed:
            return L10n.error
        case .maintenanceMode:
            return L10n.error
        case .obsoleteVersion:
            return L10n.error
        case .bannedUser:
            return L10n.error
        case .authMissingAgreement:
            return L10n.error
        case .quizTimeout:
            return L10n.error
        case let .authUnauthorized(errorMessage):
            return errorMessage
        case .resourceNotFound:
            return L10n.error
        case .userIsNotLoggedIn:
            return L10n.error
        case .cameraPermissionDenied:
            return L10n.fancamErrorCheckPermission
        case .isFirstTimeToOpenApp:
            return nil
        }
    }
}

// MARK: - CustomErrorManager

enum ErrorManager {
    static func parseError(data: Data) -> CustomError {
        let error = ErrorManager.decodeError(data: data)
        return error
    }

    private static func decodeError(data: Data) -> CustomError {
        let decoder = JSONDecoder()
        if let errorResponse = try? decoder.decode(BaseServerResponse.self, from: data) {
            return processError(error: errorResponse)
        }
        return .genericError("Error")
    }

    static func processError(error: BaseServerResponse) -> CustomError {
        switch error.meta.errorName {
        case "AuthEmailNotConfirmed":
            return .authEmailNotConfirmed
        case "MaintenanceMode":
            return .maintenanceMode
        case "ObsoleteVersion":
            return .obsoleteVersion
        case "AuthBannedUser":
            return .bannedUser
        case "AuthMissingAgreement":
            return .authMissingAgreement
        case "rest_forbidden":
            return .authUnauthorized(error.meta.errorDescription)
        case "ResourceNotFound":
            return .resourceNotFound
        default:
            return .genericError(error.meta.errorDescription)
        }
    }
}
