//
//
//  Mission.swift
//
//  Created on 09/06/22
//  Copyright © 2022 IQUII s.r.l. All rights reserved.
//

// import Foundation
//
//// MARK: - Mission
//
// public struct Mission: Hashable {
//    public var id: Int?
//    public let type: MissionType?
//    public let title: String?
//    public let description: String?
//    public let questions: String?
//    public let time: String?
//    public let coins: String?
//    public let fancam: String?
//
//    // TODO: test
//    public init(_ count: Int) {
//        switch count {
//        case 1:
//            id = 1
//            type = .survey
//            title = "Come ti sei trovato al check-in che hai avuto sulla nave?"
//            description = "Verrai reindirizzato sulla pagina di login per accedere al tuo profilo"
//            questions = "3"
//            time = "20"
//            fancam = ""
//            coins = "11"
//        case 2:
//            id = 2
//            type = .quiz
//            title = "Quanto conosci la nave MSC"
//            description = "Verrai reindirizzato sulla pagina di login per accedere al tuo profilo"
//            questions = "3"
//            time = "20"
//            fancam = ""
//            coins = "22"
//        case 3:
//            id = 3
//            type = .info
//            title = "Leggi l’articolo"
//            description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
//            questions = "3"
//            time = "20"
//            fancam = ""
//            coins = "33"
//        case 4:
//            id = 4
//            type = .fancam
//            title = "Fai una foto alla poppa della Carribean"
//            description = "Verrai reindirizzato sulla pagina di login per accedere al tuo profilo"
//            questions = "3"
//            time = "20"
//            fancam = "Fai una foto durante il tramonto al logo di poppa della Carribean"
//            coins = "44"
//        case 5:
//            id = 5
//            type = .social
//            title = "Accedi con il tuo profilo Twitter"
//            description = "Verrai reindirizzato sulla pagina di login per accedere al tuo profilo"
//            questions = "3"
//            time = "20"
//            fancam = ""
//            coins = "55"
//        case 6:
//            id = 6
//            type = .survey
//            title = "Come ti sei trovato al check-in che hai avuto sulla nave?"
//            description = "Verrai reindirizzato sulla pagina di login per accedere al tuo profilo"
//            questions = "3"
//            time = "20"
//            fancam = ""
//            coins = "44"
//        case 7:
//            id = 7
//            type = .quiz
//            title = "Quanto conosci la nave MSC?"
//            description = "Verrai reindirizzato sulla pagina di login per accedere al tuo profilo"
//            questions = "3"
//            time = "20"
//            fancam = ""
//            coins = "55"
//        case 8:
//            id = 8
//            type = .info
//            title = "That's a big bruise you have there."
//            description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
//            questions = "3"
//            time = "20"
//            fancam = ""
//            coins = "66"
//        case 9:
//            id = 9
//            type = .survey
//            title = "Quanto conosci la nave MSC?"
//            description = "Verrai reindirizzato sulla pagina di login per accedere al tuo profilo"
//            questions = "3"
//            time = "20"
//            fancam = ""
//            coins = "77"
//        case 10:
//            id = 10
//            type = .quiz
//            title = "Quanto conosci la nave MSC?"
//            description = "Verrai reindirizzato sulla pagina di login per accedere al tuo profilo"
//            questions = "3"
//            time = "20"
//            fancam = ""
//            coins = "88"
//        default:
//            id = 10
//            type = .quiz
//            title = "Quanto conosci la nave MSC?"
//            description = "Verrai reindirizzato sulla pagina di login per accedere al tuo profilo"
//            questions = "3"
//            time = "20"
//            fancam = ""
//            coins = "88"
//        }
//    }
//
//    public init(mission: MissionDataSourceModel) {
//        id = mission.id
//        type = MissionType(mission.type ?? "")
//        title = mission.title
//        description = mission.description
//        questions = mission.questions
//        time = mission.time
//        coins = mission.coins
//        fancam = mission.fancam
//    }
// }
