import Foundation
@testable import PickOne
import Testing

struct StreamingServiceLinkTests {
    @Test func eachPilotServiceOpensItsOwnSearchForTheTitle() throws {
        let netflix = try #require(StreamingServiceLink.searchURL(providerID: 8, title: "El padrino II"))
        #expect(netflix.absoluteString == "https://www.netflix.com/search?q=El%20padrino%20II")
        let prime = try #require(StreamingServiceLink.searchURL(providerID: 119, title: "Intocable"))
        #expect(prime.absoluteString == "https://www.primevideo.com/search?phrase=Intocable")
        #expect(StreamingServiceLink.searchURL(providerID: 337, title: "Up")?.host() == "www.disneyplus.com")
        #expect(StreamingServiceLink.searchURL(providerID: 1899, title: "Up")?.host() == "play.hbomax.com")
    }

    @Test func unknownServiceOrEmptyTitleHasNoLink() {
        #expect(StreamingServiceLink.searchURL(providerID: 999, title: "Up") == nil)
        #expect(StreamingServiceLink.searchURL(providerID: 8, title: "  ") == nil)
    }

    @Test func reservedCharactersAreEncodedInTheQuery() throws {
        let url = try #require(StreamingServiceLink.searchURL(providerID: 8, title: "Amélie & co?"))
        let query = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.first?.value
        #expect(query == "Amélie & co?")
    }
}
