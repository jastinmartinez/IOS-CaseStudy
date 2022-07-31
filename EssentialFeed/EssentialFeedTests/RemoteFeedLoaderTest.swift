//
//  EssentialFeedTests.swift
//  EssentialFeedTests
//
//  Created by Jastin on 30/7/22.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTest: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
     let (_, client) = makeSUT()
        XCTAssert(client.requestedUrls.isEmpty)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "given-url-load")!
        let(sut, client) = makeSUT(url: url)
        sut.load()
        XCTAssertEqual([url], client.requestedUrls)
    }
    
    func test_loadTwice_requestDataFromURLTwice() {
        let url = URL(string: "given-url-load")!
        let(sut, client) = makeSUT(url: url)
        sut.load()
        sut.load()
        XCTAssertEqual([url,url], client.requestedUrls)
    }
    
    // MARK: - HELPERS

    private func makeSUT(url: URL = URL(string: "given-url")!) -> (RemoteFeedLoader,HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url,client: client)
        return (sut,client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedUrls = [URL]()
         func get(from url: URL) {
             requestedUrls.append(url)
        }
    }
}







