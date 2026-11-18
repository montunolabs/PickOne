import Foundation

struct AvailabilityProviderPresentationModel: Identifiable, Equatable {
    let id: Int
    let name: String
    let logoURL: URL?
}

struct EligibleAvailabilityPresentationModel: Equatable {
    let providers: [AvailabilityProviderPresentationModel]
    let showsPlaybackOptionsAction: Bool
}

enum MovieAvailabilityViewState: Equatable {
    case loading
    case eligible(EligibleAvailabilityPresentationModel)
    case ineligible
    case unknown

    static let title = String(localized: "Available on")
    static let ineligibleMessage = String(localized: "Not shown as included with your services.")
    static let unknownMessage = String(localized: "We couldn't verify availability.")
    static let attribution = String(localized: "Availability data from JustWatch · may change")
    static let handoffTitle = String(localized: "View playback options on TMDB")
}
