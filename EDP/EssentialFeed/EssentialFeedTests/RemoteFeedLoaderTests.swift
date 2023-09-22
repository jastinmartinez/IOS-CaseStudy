//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Jastin on 16/9/23.
//

import XCTest
import EssentialFeed

final class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = self.makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load {_ in }
        XCTAssertEqual([url], client.requestedURLs)
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load {_ in }
        sut.load {_ in }
        XCTAssertEqual([url, url], client.requestedURLs)
        XCTAssertEqual(2, client.requestedURLs.count)
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = self.makeSUT()
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { capturedErrors.append($0) }
        let clientError = NSError(domain: "Error", code: 0)
        client.complete(with: clientError)
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    func test_load_deliversErrorOnNonHTTPResponse() {
        let (sut, client) = self.makeSUT()
        let invalidCodeSamples = [199, 201, 300, 400, 500]
        invalidCodeSamples.enumerated().forEach { index, value in
            var capturedErrors = [RemoteFeedLoader.Error]()
            sut.load { capturedErrors.append($0) }
            client.complete(withStatusCode: value, at: index)
            XCTAssertEqual(capturedErrors, [.invalidData])
        }
    }
    
    //   MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private (set) var messages =  [(url: URL, completion: (HTTPClientResult) -> Void)]()
        var requestedURLs: [URL] {
            return self.messages.map({ $0.url })
        }
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            self.messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            self.messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, at index: Int = 0) {
            let url = self.requestedURLs[index]
            let response = HTTPURLResponse(url: url,
                                           statusCode: code,
                                           httpVersion: nil,
                                           headerFields: nil)!
            self.messages[index].completion(.sucess(response))
        }
    }
}
