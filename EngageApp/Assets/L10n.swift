//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

private extension L10n {
    static func tr(_ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

enum L10n {
    // General
    static let skip = "Salta"
    static let login = "Accedi"
    static let close = "Chiudi"
    static let share = "Condividi"
    static let goOn = "Continua"
    static let cancel = "Annulla"
    static let startToAnswer = "Inizia a rispondere"
    static let sponsoredBy = "Sponsored by"
    static let timerDays = "Gio"
    static let timerHours = "Ore"
    static let timerMinutes = "Min"
    static let timerSeconds = "Sec"
    static let error = "Error"
    static let privacyTermsTitle = "Termini e condizioni"
    static let singupValidationEmail = "Inserire un email valida"
    static let standardYesterday = "Ieri"
    static let standardYearsAbbreviation = "y"
    static let name = "Nome"
    static let surname = "Cognome"
    static let email = "Email"
    static let help = "Aiuto"
    static let missions = "Missioni"
    static let catalog = "Catalogo"

    // Onboarding
    static let onBoardingStep1Title = "Primo step di onboarding"
    static let onBoardingStep2Title = "Secondo step di onboarding"
    static let onBoardingStep3Title = "Terzo step di onboarding"
    static let onBoardingstep1SubTitle = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore."
    static let onBoardingstep2SubTitle = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore."
    static let onBoardingstep3SubTitle = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore."

    // Welcome
    static let welcomeTitle = "Benvenuti in Crociera"
    static let welcomeSubTitle = "Per accedere inserisci la stessa mail utilizzata per la prenotazione"
    static let welcomeEmailBooking = "Email della prenotazione"
    static let welcomeEmailNotFound = "Non trovi la mail?"
    static let welcomeBookingNotFound = "Non hai una prenotazione?  <p>Scopri di più</p>"
    static let welcomeConfirmEmailTitle = "Conferma la tua email"
    static let welcomeConfirmEmailSubTitle = "Ti abbiamo inviato un link alla tua mail per avere conferma che a partire con noi sarai tu"
    static let welcomeOpenEmailClient = "Leggi la mail"
    static let welcomeTypeEmail = "Inserisci la tua email"

    // Survey
    static let surveyQuestionsToAnswer = "Domande da rispondere"
    static let surveyOnlyOneAnswer = "Seleziona una sola risposta"
    static let surveyPlaceholder = "Inizia a scrivere qui"
    static let surveyNumberQuestionsAnswered = "Hai risposto a tutte le domande"
    static let surveyTimeExpired = "Il tempo per rispondere è finito"
    static let surveyTimeExpiredNext = "Oooh noo ormai è troppo tardi!"
    static let surveyButtonShowResults = "Mostra i risultati"
    static let surveyButtonAlreadyAnswered = "Hai già risposto"
    static let surveyButtonNotAvailable = "Non più disponibile"
    static let surveyButtonNext = "Avvisami per la prossima"
    static let surveyButtonOtherAnswer = "Dai un'altra risposta"
    static let surveyQuizStringDateLabel = "Inizia il %1 alle %2"
    static let surveyResultsTitle = "Risultati dai nostri fan"
    static let surveyResultsInfo = "I risultati visualizzati tengono in considerazione solo le risposte chiuse"
    static let surveySuccessTitle = "Grazie mille per aver risposto!"
    static let surveySuccessSubtitle = "Abbiamo salvato il tuo contributo insieme a quello degli altri tifosi. Siamo sempre molto contenti di conoscere la tua opinione."
    static let surveyCompleted = "Survey completata!"
    static let surveyPlaceholderMessage = "Inizia a scrivere qui"
    static let surveyAnswerSubtitleSingle = "Seleziona una sola risposta"
    static let surveyAnswerSubtitleMultiple = "Puoi selezionare più di una risposta"
    static let surveyAnswerSubtitleFreeText = "Scrivi di seguito la tua risposta"
    static let surveySendAnswer = "Invia risposta"
    static let surveySendAnswers = "Invia risposte"

    // Quiz
    static let quizCloseMsgFooter = "Chiudendo questa pagina la risposta verrà conteggia come errata"
    static let quizRanking = "Classifica"
    static let quizCameLateLabel = "Sei arrivato troppo tardi!"

    // Fancam
    static let fancamShareTitle = "Condividi anche a %1!"
    static let fancamShareDescr = "Vuoi condividere questa foto anche con lo staff %1?"
    static let fancamShareButton = "Salva e condividi"
    static let fancamNotShareButton = "No, Grazie"
    static let fancamStickersButton = "Stickers"
    static let fancamFiltersButton = "Filtri"
    static let fancamSendPhoto = "Invia la foto che hai appena scattato per guadagnare coin"
    static let fancamSaveWithComment = "Salva il commento"
    static let fancamSaveWithoutComment = "Invia solo la foto"
    static let fancamAddCommentTitle = "Vuoi aggiungere qualcosa?"
    static let fancamAddCommentSubTitle = "Se vuoi allegare alla foto un commento personale questo è il tuo momento"
    static let fancamInfoTitle = "Cosa scattare per guadagnare coin?"
    static let fancamInfoSubTitle = "Fai una foto durante il tramonto al logo di poppa della Carribean"
    static let fancamInfoTakePhoto = "Inquadra il soggetto"
    static let fancamErrorCheckPermission = "Controlla i permessi della fotocamera nelle impostazioni"

    // Notifications
    static let notificationUnknown = "Notifica"
    static let notificationGoToMission = "Vai alla missione"
    static let notificationGoToMissionList = "Vai alle missioni"
    static let notificationGoToReward = "Scopri il premio"
    static let notificationGoToRewardList = "Scopri i premi"
    static let notificationGoToProfile = "Vai al profilo"

    // Launcher
    static let launcherEarnCoins1Button = "Guadagna %1 "
    static let launcherEarnCoins2Button = "Guadagna fino a %1 "
    static let launcherQuestionsQuiz = "Domande totali"
    static let launcherTimerQuiz = "Tempo per domanda"
    static let launcherQuestionsSurvey = "Domande da completare"
    static let launcherFancam = "Inquadra il soggetto"
    static let launcherEarnMoreCoins = "Guadagna altri coin"
    static let launcherRedeemReward = "Swipe per riscattare"
    static let launcherInstantWinCoins = "Coins in palio per ogni giocata"
    static let launcherInstantwinButton = "Tenta la fortuna"

    // Wallet
    static let walletTransactionDate = "%1 alle %2:%3"

    // Missions
    static let missionQuiz = "Gioca al quiz"
    static let missionSurvey = "Completa la survey"
    static let missionSocialTitle = "Collega account"
    static let missionSocialSubTitle = "Accedi con il tuo profilo %1"
    static let missionReadInfo = "Leggi l'articolo"
    static let missionFancam = "Scatta una foto"
    static let missionInstantwin = "Gioco della fortuna"
    static let missionTypeQuiz = "Quiz"
    static let missionTypeSurvey = "Survey"
    static let missionTypeInfo = "Informativa"
    static let missionTypeFancam = "Fancam"
    static let missionTypeInstantwin = "Instantwin"
    static let missionTypeSocialGoogle = "Google"
    static let missionTypeSocialFacebook = "Facebook"
    static let missionTypeSocialTwitter = "Twitter"
    static let missionTypeSocialLinkedin = "Linkedin"
    static let missionSuccessTitle = "Missione completata"
    static let missionSuccessSubTitle = "Hai appena guadagnato"
    static let missionFailureTitle = "Non è andata benissimo"
    static let missionFailureSubTitle = "Peccato, opportunità svanita"
    static let missionTimerDays = "Scade fra %0g %1h %2m"
    static let missionTimerHours = "Scade fra %0h %1m %2s"
    static let noMissionsAvailable = "Non ci sono missioni"

    // Home
    static let homeShowAll = "Mostra tutte"
    static let homeMissionsGoal = "Guadagna coins utili a riscattare i premi che trovi nel catalogo"
    static let homeCatalogGoal = "Riscatta i premi utilizzando i coins che hai accumulato"
    static let homeCatalog = "Premi"
    static let homeShowAllCatalog = "Vai al catalogo"

    // Catalog + Reward
    static let rewardTypeReal = "Premio fisico"
    static let rewardTypeDigital = "Premio digitale"
    static let rewardCoinsNotEnough = "Ti mancano ancora"
    static let rewardLimited = "Limited"
    static let rewardSwipeToRedeem = "Swipe per riscattare"
    static let rewardDropToRedeem = "Rilascia per riscattare"

    // Profile
    static let profileTitle = "Profilo"
    static let profileCruiseChange = "Cambia o esci da questa crociera"
    static let profileAccount = "Account"
    static let profileSupport = "Supporto"
    static let profileMyAccount = "I miei dati"
    static let profileCruiseTitle = "Capitano, vuole davvero abbandonare la nave?"
    static let profileToS = "Consensi & Privacy"
    static let profileHow = "Come funziona"
    static let profileHelp = "Help"
    static let profileExit = "Esci dalla nave"
    static let profileCallHelp = "Contatta l'assistenza"
    static let profileMyAcountTitle = "Il mio account"
    static let profileSave = "Salva modifiche"
    static let profileLogout = "Esci dall'account"

    // Help
    static let helpTitle = "What Lorraine, what? That's a big bruise"
    static let helpSubTitle = "No, get out of town, my mom thinks I'm going camping with the guys. Well, Jennifer, my mother would freak out"
    static let helpGoToWeb = "Vai al sito web"
    static let helpToS = "Termini e condizioni"
    static let helpProblems = "Non riesci a risolvere?"
    static let helpPhone = "(+39) 02 3041 6161"
    static let helpEmail = "Scrivi una mail"

    // Privacy
    static let privacyPolicyTitle = "Privacy Policy"
    static let privacyTitleBS = "Consensi e privacy"
    static let privacySubTitleBS = "Accetta queste condizioni"
    static let deleteAccount = "Elimina account"
    static let deleteAccountConfirm = "Vuoi eliminare l’account?"
    static let privacyNewsletter = "Desidero iscrivermi alla newsletter"
    static let privacyMarketing = "Desidero ricevere informazioni relative ad iniziative di marketing"
    static let privacyMarketingExtra = "Desidero ricevere informazioni relative ad iniziative di marketing di terze parti"
    static let privacyProfiling = "Acconsento alla profilazione delle mie abitudini per conto di terzi"
    static let privacyProfilingExtra = "Con la prenotazione sono stati accetati i <t>Termini di Servizio</t> e le <p>Norme sulla Privacy</p>"
}
