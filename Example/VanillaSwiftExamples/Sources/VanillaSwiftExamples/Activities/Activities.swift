enum Activity: String, CaseIterable {
    case workingOut

    case practicingForASport

    case playingASport

    case swimmingLaps

    case yogaClass

    case running

    case pilates

    case homeRenovations

    case meditating

    case studyingForAnExam

    case completingAnAssignment

    case readingATextbook

    case writingAnArticle

    case editingAVideo

    case learningANewSkill

    case journalling

    case joiningASocialGroup

    case goingToARally

    case attendingAnImprovClass

    case goingToChurch

    case spendingTimeWithFriends

    var text: String {
        rawValue
            .replacingOccurrences(
                of: "[A-Z]",
                with: " $0",
                options: .regularExpression
            )
            .capitalized
    }
}
