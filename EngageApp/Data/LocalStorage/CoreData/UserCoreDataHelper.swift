//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import CoreData
import Foundation

class UserCoreDataHelper {
    private var context: NSManagedObjectContext = CoreDataManager(modelName: "User").managedObjectContext

    func getUser() -> [User] {
        var fetchingUser = [User]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        do {
            fetchingUser = try context.fetch(fetchRequest) as! [User]
        } catch {
            print("Error while fetching the user")
        }

        return fetchingUser
    }

    private func loadUserFromFetchRequest(request: NSFetchRequest<User>) -> [User] {
        var array = [User]()
        do {
            array = try context.fetch(request)
        } catch {
            print(error)
        }

        return array
    }

    func saveUser(user: UserInfo) {
        guard let userId = user.id else { return }

        let id = Int(userId) ?? 0
        if IsStored(id: id) {
            deleteUser(id: id)
        }

        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else { return }

        let _user = User(entity: entity, insertInto: context)
        _user.id = Int64(user.id ?? "") ?? 0
        _user.coins = Int32(user.coins ?? 0)
        _user.agreeMarketing = user.agreeMarketing ?? false
        _user.agreeMarketingThirdParty = user.agreeMarketingThirdParty ?? false
        _user.agreeNewsletter = user.agreeNewsletter ?? false
        _user.agreeProfiling = user.agreeProfiling ?? false
        _user.agreeProfilingThirdParty = user.agreeProfilingThirdParty ?? false
        _user.agreeTerms = user.agreeTerms ?? false
        _user.birthday = user.profile?.birthday ?? ""
        _user.email = user.profile?.email?.email ?? ""
        _user.firstName = user.profile?.firstName ?? ""
        _user.lastName = user.profile?.lastName ?? ""
        _user.gender = user.profile?.gender ?? ""
        _user.phone = user.profile?.mobile ?? ""

        context.performAndWait {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }

    func loadUserFromID(id: Int) -> User? {
        let request: NSFetchRequest<User> = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false

        let predicate = NSPredicate(format: "id = %i", id)
        request.predicate = predicate

        let users = loadUserFromFetchRequest(request: request)
        if users.count > 0 {
            return users[0]
        } else {
            return nil
        }
    }

    func IsStored(id: Int) -> Bool {
        if let _ = loadUserFromID(id: id) {
            return true
        }
        return false
    }

    func deleteUser(id: Int) {
        if let user = loadUserFromID(id: id) {
            context.delete(user)

            context.performAndWait {
                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}
