import Foundation

/// Builds the web search page of a streaming service for a movie title.
///
/// None of the services documents a way to open a specific movie from a title,
/// so PickOne opens the service's own search for the title. On an iPhone with
/// the service's app installed, iOS may route these web links into the app.
enum StreamingServiceLink {
    static func searchURL(providerID: Int, title: String) -> URL? {
        let query = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty, let base = searchBase(providerID: providerID) else {
            return nil
        }
        var components = URLComponents(string: base.url)
        components?.queryItems = [URLQueryItem(name: base.queryName, value: query)]
        return components?.url
    }

    private static func searchBase(providerID: Int) -> (url: String, queryName: String)? {
        switch providerID {
            case PilotStreamingService.netflix.providerID:
                ("https://www.netflix.com/search", "q")
            case PilotStreamingService.amazonPrimeVideo.providerID:
                ("https://www.primevideo.com/search", "phrase")
            case PilotStreamingService.disneyPlus.providerID:
                ("https://www.disneyplus.com/search", "q")
            case PilotStreamingService.hboMax.providerID:
                ("https://play.hbomax.com/search", "q")
            default:
                nil
        }
    }
}
