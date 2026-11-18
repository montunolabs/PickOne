import Foundation

enum ViewerProfileCopy {
    static let serviceTitle = String(localized: "Streaming services")
    static let region = String(localized: "Availability region: Spain")
    static let serviceGuidance =
        String(localized: "Choose the services where you can watch movies without paying extra.")
    static let progress = String(localized: "8 taste signals help us start with more confidence.")
    static let lowSignalTitle = String(localized: "Want to rate a few more?")
    static let lowSignalBody =
        String(localized: "We can start broadly with what you have told us, or you can rate a few more movies first.")
    static let resetTitle = String(localized: "Reset preferences?")
    static let resetBody =
        String(
            localized: "This removes your streaming services and movie calibration. Your Watchlist and Search History will stay."
        )
    static let unsupportedTitle = String(localized: "Preferences need to be reset")
    static let unsupportedBody =
        String(
            localized: "This saved movie data version isn't supported by this build. You can try again or reset all movie data."
        )
    static let corruptTitle = String(localized: "Preferences couldn't be read")
    static let corruptBody =
        String(
            localized: "Your saved movie data is damaged and couldn't be recovered. You can try again or reset all movie data."
        )
}

enum AppRootViewState: Equatable {
    case loading
    case onboarding
    case main
    case recovery(ViewerProfileRecoveryReason)
}

enum CalibrationPresentationMode: Equatable {
    case firstOnboarding
    case recalibration
}

struct CalibrationMovieCardPresentationModel: Equatable {
    let id: Int
    let primaryText: String
    let secondaryText: String?
    let posterURL: URL?
    let fallbackTitle: String
}

@MainActor
enum CalibrationMoviePresentationMapper {
    static func map(
        catalogMovie: CalibrationMovie,
        metadata: CalibrationMovieMetadata?
    ) -> CalibrationMovieCardPresentationModel {
        let primary = nonempty(metadata?.title) ?? catalogMovie.titleKnownInSpain
        let original = nonempty(metadata?.originalTitle) ?? catalogMovie.originalOrEnglishTitle
        let year = metadata?.releaseYear ?? catalogMovie.year
        let equivalent = normalized(primary) == normalized(original)

        return CalibrationMovieCardPresentationModel(
            id: catalogMovie.id,
            primaryText: equivalent ? "\(primary) · \(year)" : primary,
            secondaryText: equivalent ? nil : "\(original) · \(year)",
            posterURL: ImageURLBuilder.posterURL(path: metadata?.posterPath, size: .posterLarge),
            fallbackTitle: catalogMovie.titleKnownInSpain
        )
    }

    static func normalized(_ title: String) -> String {
        title
            .split(whereSeparator: \.isWhitespace)
            .joined(separator: " ")
            .lowercased()
    }

    private static func nonempty(_ value: String?) -> String? {
        guard let trimmed = value?.trimmingCharacters(in: .whitespacesAndNewlines),
              !trimmed.isEmpty else { return nil }
        return trimmed
    }
}
