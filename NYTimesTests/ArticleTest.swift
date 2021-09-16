//
//  ArticleTest.swift
//  NYTimesTests
//
//  Created by Atif Khan on 16/09/2021.
//

import XCTest
@testable import NYTimes

class ArticleTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArticle() throws {
        
        let article = Article(uri: "nyt://article/bbc9aa5b-c108-51c3-8021-e09c90aa3e5f"
                              , url: "https://www.nytimes.com/2021/09/13/technology/apple-software-update-spyware-nso-group.html",
                              id: 100000007970678,
                              assetId: 100000007970678,
                              source: "New York Times",
                              publishedDate: "2021-09-13",
                              updated: "2021-09-14 18:29:17",
                              section: "Technology",
                              subsection: "",
                              nytdsection: "technology",
                              adxKeywords: "iPhone;Computer Security;Cyberwarfare and Defense;Human Rights and Human Rights Violations;NSO Group;Apple Inc;Citizen Lab",
                              byline: "By Nicole Perlroth",
                              type: "Article",
                              title: "Apple Issues Emergency Security Updates to Close a Spyware Flaw",
                              abstract: "Researchers at Citizen Lab found that NSO Group, an Israeli spyware company, had infected Apple products without so much as a click.",
                              desFacet:
                                ["iPhone",
                                "Computer Security",
                                "Cyberwarfare and Defense",
                                "Human Rights and Human Rights Violations"
                                ],
                              orgFacet:
                                ["NSO Group",
                                 "Apple Inc",
                                 "Citizen Lab"],
                              perFacet: [],
                              geoFacet:[],
                              media: [Media(type:"image",
                                            subtype: "photo",
                                            caption: "Apple products, including iPhones, have been vulnerable since at least March.",
                                            copyright: "Loic Venance/Agence France-Presse — Getty Images",
                                            approvedForSyndication: 1,
                                            mediaMetadata: [MediaMetadatum(url: "https://static01.nyt.com/images/2021/09/13/business/13spyware1/13spyware1-thumbStandard.jpg",
                                                   format: "Standard Thumbnail",
                                                   height: 75,
                                                   width: 75)])],
                              etaId: 0)
        
        XCTAssertNotNil(article)
        XCTAssertEqual(article.uri, "nyt://article/bbc9aa5b-c108-51c3-8021-e09c90aa3e5f")
        XCTAssertEqual(article.url, "https://www.nytimes.com/2021/09/13/technology/apple-software-update-spyware-nso-group.html")
        XCTAssertEqual(article.id, 100000007970678)
        XCTAssertEqual(article.assetId, 100000007970678)
        XCTAssertEqual(article.source, "New York Times")
        XCTAssertEqual(article.publishedDate, "2021-09-13")
        XCTAssertEqual(article.updated, "2021-09-14 18:29:17")
        XCTAssertEqual(article.section, "Technology")
        
    }

}
