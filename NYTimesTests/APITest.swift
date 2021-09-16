//
//  APITest.swift
//  NYTimesTests
//
//  Created by Atif Khan on 16/09/2021.
//

import XCTest
@testable import NYTimes

class APITest: XCTestCase {

    var client:  HttpClient!
    let mockSession = MockURLSession()
    
    override func setUp() {
        client = HttpClient(baseUrl: BASE_URL, session: mockSession)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBaseUrl() {
                
        XCTAssertFalse(BASE_URL.isEmpty)
        XCTAssertEqual(BASE_URL, "https://api.nytimes.com/")
    }
    
    func testGetArticlesWithExpectedURLHostAndPath() {
        
        let expectedData = "{}".data(using: .utf8)
        
        mockSession.nextData = expectedData
        
        let path = "svc/mostpopular/v2/viewed/7.json"
                
        client.request(path: path, method: .get, params: [:]) { (data, err) in  }
        
        var url = BASE_URL.replacingOccurrences(of: "https://", with: "")
        url.removeLast()
        
        XCTAssertEqual(mockSession.lastURL?.host, url)
        XCTAssertEqual(mockSession.lastURL?.path, "/" + path)
    }
    
    func testGetArticlesWithExpectedData() {
        
        let expectedData = expectedResponse.data(using: .utf8)
        
        mockSession.nextData = expectedData
        
        let path = "svc/mostpopular/v2/viewed/7.json"
        
        var actualData: Data?
        
        client.request(path: path, method: .get, params: [:]) { (data, err) in
            actualData = data as? Data
        }
        
        XCTAssertNotNil(actualData)
        XCTAssertEqual(actualData, expectedData)
    }
    
    func testGetarticlesWithParsedData() {
        
        var articlesResponse: ArticleResponse?
        
        let articlesExpectation = expectation(description: "articles")
        
        let worker = ArticleListFetchWorker(client: HttpClient(baseUrl: BASE_URL, session: URLSession.shared))
        worker.fetchArticles(.sevenDay) { (resp, err) in
            articlesResponse = resp
            articlesExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (err) in
            XCTAssertNotNil(articlesResponse)
        }
    }

}


let expectedResponse = """
                    {
                        "status": "OK",
                        "copyright": "Copyright (c) 2021 The New York Times Company.  All Rights Reserved.",
                        "num_results": 20,
                        "results": [
                            {
                                "uri": "nyt://article/bbc9aa5b-c108-51c3-8021-e09c90aa3e5f",
                                "url": "https://www.nytimes.com/2021/09/13/technology/apple-software-update-spyware-nso-group.html",
                                "id": 100000007970678,
                                "asset_id": 100000007970678,
                                "source": "New York Times",
                                "published_date": "2021-09-13",
                                "updated": "2021-09-14 18:29:17",
                                "section": "Technology",
                                "subsection": "",
                                "nytdsection": "technology",
                                "adx_keywords": "iPhone;Computer Security;Cyberwarfare and Defense;Human Rights and Human Rights Violations;NSO Group;Apple Inc;Citizen Lab",
                                "column": null,
                                "byline": "By Nicole Perlroth",
                                "type": "Article",
                                "title": "Apple Issues Emergency Security Updates to Close a Spyware Flaw",
                                "abstract": "Researchers at Citizen Lab found that NSO Group, an Israeli spyware company, had infected Apple products without so much as a click.",
                                "des_facet": [
                                    "iPhone",
                                    "Computer Security",
                                    "Cyberwarfare and Defense",
                                    "Human Rights and Human Rights Violations"
                                ],
                                "org_facet": [
                                    "NSO Group",
                                    "Apple Inc",
                                    "Citizen Lab"
                                ],
                                "per_facet": [],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Apple products, including iPhones, have been vulnerable since at least March.",
                                        "copyright": "Loic Venance/Agence France-Presse — Getty Images",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/13/business/13spyware1/13spyware1-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/13/business/13spyware1/merlin_192808176_27a72843-28a5-457b-915b-256285d1b598-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/13/business/13spyware1/merlin_192808176_27a72843-28a5-457b-915b-256285d1b598-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/fc25078b-46fc-5c8c-a7e1-f717eae3bec2",
                                "url": "https://www.nytimes.com/2021/09/11/us/where-was-trump-9-11-anniversary.html",
                                "id": 100000007968133,
                                "asset_id": 100000007968133,
                                "source": "New York Times",
                                "published_date": "2021-09-11",
                                "updated": "2021-09-12 11:55:26",
                                "section": "U.S.",
                                "subsection": "",
                                "nytdsection": "u.s.",
                                "adx_keywords": "September 11 (2001);United States Politics and Government;Fires and Firefighters;Trump, Donald J;Manhattan (NYC)",
                                "column": null,
                                "byline": "By Katie Rogers",
                                "type": "Article",
                                "title": "Where’s Trump on 9/11? Not at ground zero.",
                                "abstract": "The former president “decided to honor the day with different stops,” his spokeswoman said, including a visit to a Manhattan police precinct.",
                                "des_facet": [
                                    "September 11 (2001)",
                                    "United States Politics and Government",
                                    "Fires and Firefighters"
                                ],
                                "org_facet": [],
                                "per_facet": [
                                    "Trump, Donald J"
                                ],
                                "geo_facet": [
                                    "Manhattan (NYC)"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Former President Donald J. Trump visited the 17th Precinct of the New York City Police Department on Saturday.",
                                        "copyright": "Mario Anzuoni/Reuters",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/11/us/politics/11sept11-anniversary-blog-trump2/11sept11-anniversary-blog-trump2-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/11/us/politics/11sept11-anniversary-blog-trump2/merlin_194548848_f4e96501-8d37-473a-89df-1606d8b1a07a-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/11/us/politics/11sept11-anniversary-blog-trump2/merlin_194548848_f4e96501-8d37-473a-89df-1606d8b1a07a-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/40e3ae6b-8906-5cb7-aae8-2ecca5101e53",
                                "url": "https://www.nytimes.com/2021/09/08/us/politics/biden-vaccine-mandate-speech.html",
                                "id": 100000007962706,
                                "asset_id": 100000007962706,
                                "source": "New York Times",
                                "published_date": "2021-09-08",
                                "updated": "2021-09-09 17:08:27",
                                "section": "U.S.",
                                "subsection": "Politics",
                                "nytdsection": "u.s.",
                                "adx_keywords": "Coronavirus (2019-nCoV);United States Politics and Government;Biden, Joseph R Jr;Psaki, Jennifer R",
                                "column": null,
                                "byline": "By Katie Rogers",
                                "type": "Article",
                                "title": "President Biden is expected to impose new vaccination mandates in a speech on Thursday.",
                                "abstract": "White House officials said that Mr. Biden would also detail initiatives meant to pressure private businesses, federal agencies and schools.",
                                "des_facet": [
                                    "Coronavirus (2019-nCoV)",
                                    "United States Politics and Government"
                                ],
                                "org_facet": [],
                                "per_facet": [
                                    "Biden, Joseph R Jr",
                                    "Psaki, Jennifer R"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "President Biden has addressed the nation about vaccines before, including this time in May.",
                                        "copyright": "Doug Mills/The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/08/multimedia/08virus-Biden/08virus-Biden-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/08/multimedia/08virus-Biden/08virus-Biden-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/08/multimedia/08virus-Biden/08virus-Biden-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/c0aa791d-4b81-5f5c-8a40-5990ca425056",
                                "url": "https://www.nytimes.com/2021/09/10/science/kea-beak-tools.html",
                                "id": 100000007962328,
                                "asset_id": 100000007962328,
                                "source": "New York Times",
                                "published_date": "2021-09-10",
                                "updated": "2021-09-11 13:39:02",
                                "section": "Science",
                                "subsection": "",
                                "nytdsection": "science",
                                "adx_keywords": "Parrots;Animal Cognition;Animal Behavior;Tools;Research;your-feed-science;your-feed-animals;Scientific Reports (Journal);New Zealand",
                                "column": null,
                                "byline": "By Nicholas Bakalar",
                                "type": "Article",
                                "title": "Bruce Is a Parrot With a Broken Beak. So He Invented a Tool.",
                                "abstract": "The bird is a kea from New Zealand, and his fabrication of an instrument to help him preen his feathers appears to be unique, researchers say.",
                                "des_facet": [
                                    "Parrots",
                                    "Animal Cognition",
                                    "Animal Behavior",
                                    "Tools",
                                    "Research",
                                    "your-feed-science",
                                    "your-feed-animals"
                                ],
                                "org_facet": [
                                    "Scientific Reports (Journal)"
                                ],
                                "per_facet": [],
                                "geo_facet": [
                                    "New Zealand"
                                ],
                                "media": [],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/571aa3b3-1cc6-5dd0-bdd6-7834c32e4ec7",
                                "url": "https://www.nytimes.com/2021/09/08/arts/television/blues-clues-steve-burns.html",
                                "id": 100000007961317,
                                "asset_id": 100000007961317,
                                "source": "New York Times",
                                "published_date": "2021-09-08",
                                "updated": "2021-09-09 15:00:29",
                                "section": "Arts",
                                "subsection": "Television",
                                "nytdsection": "arts",
                                "adx_keywords": "Television;Fans (Persons);Burns, Steven;Nick Jr (TV Network)",
                                "column": null,
                                "byline": "By Tiffany May",
                                "type": "Article",
                                "title": "First Host of ‘Blue’s Clues’ Returns, Striking a Chord With Grown-Ups",
                                "abstract": "Steve Burns, who had a complicated relationship with the popular children’s show he hosted for six years, addressed his viewers almost two decades after his “kind of abrupt” departure.",
                                "des_facet": [
                                    "Television",
                                    "Fans (Persons)"
                                ],
                                "org_facet": [
                                    "Nick Jr (TV Network)"
                                ],
                                "per_facet": [
                                    "Burns, Steven"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "The original host of “Blue’s Clues,” Steve Burns, appeared in a video posted on Twitter on Tuesday, nearly 20 years after he suddenly exited the show.",
                                        "copyright": "Nickelodeon",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/08/multimedia/08xp-bluesclues/08xp-bluesclues-thumbStandard.png",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/08/multimedia/08xp-bluesclues/08xp-bluesclues-mediumThreeByTwo210.png",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/08/multimedia/08xp-bluesclues/08xp-bluesclues-mediumThreeByTwo440.png",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/e5eb9722-cce1-5efc-aec9-ec7785fcd74f",
                                "url": "https://www.nytimes.com/2021/09/09/us/politics/biden-mandates-vaccines.html",
                                "id": 100000007964893,
                                "asset_id": 100000007964893,
                                "source": "New York Times",
                                "published_date": "2021-09-09",
                                "updated": "2021-09-13 13:28:40",
                                "section": "U.S.",
                                "subsection": "Politics",
                                "nytdsection": "u.s.",
                                "adx_keywords": "Coronavirus (2019-nCoV);Coronavirus Delta Variant;Vaccination and Immunization;Vaccination Proof and Immunization Records;Government Employees;Workplace Hazards and Violations;Disease Rates;United States Politics and Government;Biden, Joseph R Jr;American Federation of Government Employees;Labor Department (US);United States",
                                "column": null,
                                "byline": "By Katie Rogers and Sheryl Gay Stolberg",
                                "type": "Article",
                                "title": "Biden Mandates Vaccines for Workers, Saying, ‘Our Patience Is Wearing Thin’",
                                "abstract": "Initially reluctant to enact mandates, the president is now moving aggressively to require vaccination as the Delta variant races across the country.",
                                "des_facet": [
                                    "Coronavirus (2019-nCoV)",
                                    "Coronavirus Delta Variant",
                                    "Vaccination and Immunization",
                                    "Vaccination Proof and Immunization Records",
                                    "Government Employees",
                                    "Workplace Hazards and Violations",
                                    "Disease Rates",
                                    "United States Politics and Government"
                                ],
                                "org_facet": [
                                    "American Federation of Government Employees",
                                    "Labor Department (US)"
                                ],
                                "per_facet": [
                                    "Biden, Joseph R Jr"
                                ],
                                "geo_facet": [
                                    "United States"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "President Biden expressed his frustration with the 80 million Americans who were eligible for vaccination but had not received it.",
                                        "copyright": "Al Drago for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/09/us/politics/09dc-virus-biden-2/merlin_194446158_2c7094f6-e9db-4382-b0e6-1541278e85a5-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/09/us/politics/09dc-virus-biden-2/merlin_194446158_2c7094f6-e9db-4382-b0e6-1541278e85a5-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/09/us/politics/09dc-virus-biden-2/merlin_194446158_2c7094f6-e9db-4382-b0e6-1541278e85a5-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/81333ae8-4e3a-5dea-8953-5585f8d310cf",
                                "url": "https://www.nytimes.com/2021/09/09/business/osha-vaccine-biden-mandate.html",
                                "id": 100000007964595,
                                "asset_id": 100000007964595,
                                "source": "New York Times",
                                "published_date": "2021-09-09",
                                "updated": "2021-09-15 12:59:03",
                                "section": "Business",
                                "subsection": "",
                                "nytdsection": "business",
                                "adx_keywords": "Labor and Jobs;Vaccination and Immunization;Workplace Hazards and Violations;Coronavirus (2019-nCoV);United States Politics and Government;Biden, Joseph R Jr;Occupational Safety and Health Administration;Dorsey & Whitney;Labor Department (US)",
                                "column": null,
                                "byline": "By Lauren Hirsch",
                                "type": "Article",
                                "title": "Biden Asks OSHA to Order Vaccine Mandates at Large Employers",
                                "abstract": "The agency is expected to issue an emergency temporary standard to carry out the requirement, which will affect more than 80 million workers.",
                                "des_facet": [
                                    "Labor and Jobs",
                                    "Vaccination and Immunization",
                                    "Workplace Hazards and Violations",
                                    "Coronavirus (2019-nCoV)",
                                    "United States Politics and Government"
                                ],
                                "org_facet": [
                                    "Occupational Safety and Health Administration",
                                    "Dorsey & Whitney",
                                    "Labor Department (US)"
                                ],
                                "per_facet": [
                                    "Biden, Joseph R Jr"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "A new rule requiring vaccinations or regular tests would apply to companies with more than 100 employees.",
                                        "copyright": "Jenna Schoenefeld for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/10/business/10osha-print/merlin_181351614_e058ef91-78d2-411a-ba8f-ddaa0b09fed2-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/10/business/10osha-print/merlin_181351614_e058ef91-78d2-411a-ba8f-ddaa0b09fed2-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/10/business/10osha-print/merlin_181351614_e058ef91-78d2-411a-ba8f-ddaa0b09fed2-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/554bf158-5950-50d4-b9e5-ef34ee6996bb",
                                "url": "https://www.nytimes.com/2021/09/10/world/asia/us-air-strike-drone-kabul-afghanistan-isis.html",
                                "id": 100000007963790,
                                "asset_id": 100000007963790,
                                "source": "New York Times",
                                "published_date": "2021-09-10",
                                "updated": "2021-09-15 22:42:34",
                                "section": "World",
                                "subsection": "Asia Pacific",
                                "nytdsection": "world",
                                "adx_keywords": "Drones (Pilotless Planes);Targeted Killings;United States Defense and Military Forces;Civilian Casualties;Afghanistan War (2001- );Deaths (Fatalities);Bombs and Explosives;Terrorism;Taliban;Islamic State Khorasan;Kabul (Afghanistan)",
                                "column": null,
                                "byline": "By Matthieu Aikins, Christoph Koettl, Evan Hill and Eric Schmitt",
                                "type": "Article",
                                "title": "Times Investigation: In U.S. Drone Strike, Evidence Suggests No ISIS Bomb",
                                "abstract": "U.S. officials said a Reaper drone followed a car for hours and then fired based on evidence it was carrying explosives. But in-depth video analysis and interviews at the site cast doubt on that account.",
                                "des_facet": [
                                    "Drones (Pilotless Planes)",
                                    "Targeted Killings",
                                    "United States Defense and Military Forces",
                                    "Civilian Casualties",
                                    "Afghanistan War (2001- )",
                                    "Deaths (Fatalities)",
                                    "Bombs and Explosives",
                                    "Terrorism"
                                ],
                                "org_facet": [
                                    "Taliban",
                                    "Islamic State Khorasan"
                                ],
                                "per_facet": [],
                                "geo_facet": [
                                    "Kabul (Afghanistan)"
                                ],
                                "media": [],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/9d5ac605-9878-5366-96f0-8e5c2bc794f2",
                                "url": "https://www.nytimes.com/2021/09/10/us/politics/california-stealthing-law-condoms.html",
                                "id": 100000007964017,
                                "asset_id": 100000007964017,
                                "source": "New York Times",
                                "published_date": "2021-09-10",
                                "updated": "2021-09-11 12:18:16",
                                "section": "U.S.",
                                "subsection": "Politics",
                                "nytdsection": "u.s.",
                                "adx_keywords": "Law and Legislation;State Legislatures;Condoms;Sex Crimes;California",
                                "column": null,
                                "byline": "By Isabella Grullón Paz",
                                "type": "Article",
                                "title": "California Moves to Outlaw ‘Stealthing,’ or Removing Condom Without Consent",
                                "abstract": "The bill, which the Legislature approved unanimously and which awaits the governor’s signature, would make it a civil offense to remove a condom during intercourse without a partner’s consent.",
                                "des_facet": [
                                    "Law and Legislation",
                                    "State Legislatures",
                                    "Condoms",
                                    "Sex Crimes"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [
                                    "California"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "",
                                        "copyright": "Tony Cenicola/The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/10/lens/10xp-stealthing/10xp-stealthing-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/10/lens/10xp-stealthing/10xp-stealthing-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/10/lens/10xp-stealthing/10xp-stealthing-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/9a936bcb-b5eb-5a50-9a35-2ffa5fd7ae4c",
                                "url": "https://www.nytimes.com/2021/09/13/style/met-gala-billie-eilish.html",
                                "id": 100000007966405,
                                "asset_id": 100000007966405,
                                "source": "New York Times",
                                "published_date": "2021-09-13",
                                "updated": "2021-09-15 22:39:19",
                                "section": "Style",
                                "subsection": "",
                                "nytdsection": "style",
                                "adx_keywords": "Met Gala;Fashion and Apparel;Fur;Animal Abuse, Rights and Welfare;Dresses;Eilish, Billie;Bolen, Alexander Lytton;Oscar de la Renta LLC",
                                "column": null,
                                "byline": "By Jessica Testa",
                                "type": "Article",
                                "title": "Billie Eilish Sets a Condition for Her Dress: No More Fur",
                                "abstract": "The story behind the beige-carpet look.",
                                "des_facet": [
                                    "Met Gala",
                                    "Fashion and Apparel",
                                    "Fur",
                                    "Animal Abuse, Rights and Welfare",
                                    "Dresses"
                                ],
                                "org_facet": [
                                    "Oscar de la Renta LLC"
                                ],
                                "per_facet": [
                                    "Eilish, Billie",
                                    "Bolen, Alexander Lytton"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Billie Eilish in Oscar de la Renta at the Met Gala.",
                                        "copyright": "Nina Westervelt for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/16/fashion/met-gala-nina-1405/met-gala-nina-1405-thumbStandard-v2.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/16/fashion/met-gala-nina-1405/met-gala-nina-1405-mediumThreeByTwo210-v2.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/16/fashion/met-gala-nina-1405/met-gala-nina-1405-mediumThreeByTwo440-v2.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/36556fb7-3338-55bb-ab7d-d04f84725d56",
                                "url": "https://www.nytimes.com/2021/09/13/style/simone-biles-met-gala-dress.html",
                                "id": 100000007966387,
                                "asset_id": 100000007966387,
                                "source": "New York Times",
                                "published_date": "2021-09-13",
                                "updated": "2021-09-15 22:39:02",
                                "section": "Style",
                                "subsection": "",
                                "nytdsection": "style",
                                "adx_keywords": "Met Gala;Dresses;Biles, Simone",
                                "column": null,
                                "byline": "By Jessica Testa",
                                "type": "Article",
                                "title": "Simone Biles Is a Showgirl",
                                "abstract": "The story behind the beige-carpet look.",
                                "des_facet": [
                                    "Met Gala",
                                    "Dresses"
                                ],
                                "org_facet": [],
                                "per_facet": [
                                    "Biles, Simone"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Simone Biles wore Area at the Met Gala.",
                                        "copyright": "Nina Westervelt for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/16/fashion/met-gala-nina-4259/met-gala-nina-4259-thumbStandard-v3.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/16/fashion/met-gala-nina-4259/met-gala-nina-4259-mediumThreeByTwo210-v3.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/16/fashion/met-gala-nina-4259/met-gala-nina-4259-mediumThreeByTwo440-v3.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/a092ddca-cf99-5640-8a61-f0b77c052703",
                                "url": "https://www.nytimes.com/2021/09/11/us/9-11-photos-images.html",
                                "id": 100000007941764,
                                "asset_id": 100000007941764,
                                "source": "New York Times",
                                "published_date": "2021-09-11",
                                "updated": "2021-09-13 04:19:17",
                                "section": "U.S.",
                                "subsection": "",
                                "nytdsection": "u.s.",
                                "adx_keywords": "September 11 (2001);World Trade Center (Manhattan, NY);Photography;Funerals and Memorials;Fires and Firefighters;New York Times",
                                "column": null,
                                "byline": "By The New York Times",
                                "type": "Article",
                                "title": "The Photographs of 9/11",
                                "abstract": "Photographers reflect on shooting the terrorist attacks of 9/11 and their aftermath.",
                                "des_facet": [
                                    "September 11 (2001)",
                                    "World Trade Center (Manhattan, NY)",
                                    "Photography",
                                    "Funerals and Memorials",
                                    "Fires and Firefighters"
                                ],
                                "org_facet": [
                                    "New York Times"
                                ],
                                "per_facet": [],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "",
                                        "copyright": "Krista Niles/The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/12/multimedia/00anniv911-photoreflections7/00anniv911-photoreflections7-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/12/multimedia/00anniv911-photoreflections7/merlin_193347993_e4b17ec5-5041-4038-bdd0-243f9f5dc418-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/12/multimedia/00anniv911-photoreflections7/merlin_193347993_e4b17ec5-5041-4038-bdd0-243f9f5dc418-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/d772cb7b-c83c-5775-8454-259118a4facd",
                                "url": "https://www.nytimes.com/2021/09/07/opinion/biden-failed-afghanistan.html",
                                "id": 100000007960040,
                                "asset_id": 100000007960040,
                                "source": "New York Times",
                                "published_date": "2021-09-07",
                                "updated": "2021-09-09 03:42:21",
                                "section": "Opinion",
                                "subsection": "",
                                "nytdsection": "opinion",
                                "adx_keywords": "Afghanistan War (2001- );United States Politics and Government;Law and Legislation;Infrastructure (Public Works);American Jobs Plan (2021);Biden, Joseph R Jr;Democratic Party;House of Representatives;Senate",
                                "column": null,
                                "byline": "By Bret Stephens",
                                "type": "Article",
                                "title": "Another Failed Presidency at Hand",
                                "abstract": "It starts by acknowledging the gravity of Joe Biden’s blunders.",
                                "des_facet": [
                                    "Afghanistan War (2001- )",
                                    "United States Politics and Government",
                                    "Law and Legislation",
                                    "Infrastructure (Public Works)",
                                    "American Jobs Plan (2021)"
                                ],
                                "org_facet": [
                                    "Democratic Party",
                                    "House of Representatives",
                                    "Senate"
                                ],
                                "per_facet": [
                                    "Biden, Joseph R Jr"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "  ",
                                        "copyright": "Kenny Holston for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/09/opinion/07stephens-lead/merlin_191158389_2a65bfed-4e32-4965-a539-d9222e7aa29b-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/09/opinion/07stephens-lead/07stephens-lead-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/09/opinion/07stephens-lead/07stephens-lead-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/a1ca21b2-9dc8-5248-bcd9-81fe33122382",
                                "url": "https://www.nytimes.com/2021/09/11/us/covid-vaccine-religion-exemption.html",
                                "id": 100000007951042,
                                "asset_id": 100000007951042,
                                "source": "New York Times",
                                "published_date": "2021-09-11",
                                "updated": "2021-09-15 14:15:06",
                                "section": "U.S.",
                                "subsection": "",
                                "nytdsection": "u.s.",
                                "adx_keywords": "Coronavirus (2019-nCoV);Vaccination and Immunization;Freedom of Religion;Religion-State Relations;Government Employees;Workplace Hazards and Violations;United States",
                                "column": null,
                                "byline": "By Ruth Graham",
                                "type": "Article",
                                "title": "Vaccine Resisters Seek Religious Exemptions. But What Counts as Religious?",
                                "abstract": "Major denominations are essentially unanimous in their support of the vaccines against Covid-19, but individuals who object are citing their personal faith for support.",
                                "des_facet": [
                                    "Coronavirus (2019-nCoV)",
                                    "Vaccination and Immunization",
                                    "Freedom of Religion",
                                    "Religion-State Relations",
                                    "Government Employees",
                                    "Workplace Hazards and Violations"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [
                                    "United States"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Crisann Holmes has applied for an exemption to her employer&rsquo;s vaccine mandate.",
                                        "copyright": "Kaiti Sullivan for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/12/us/12vaccine-religous-exemptions-print1/00vaccine-religous-exemptions-1-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/12/us/12vaccine-religous-exemptions-print1/12vaccine-religous-exemptions-print1-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/12/us/12vaccine-religous-exemptions-print1/12vaccine-religous-exemptions-print1-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/9a0b5364-beee-5dde-be64-f10d5dd13a1d",
                                "url": "https://www.nytimes.com/2021/09/14/arts/television/norm-macdonald-dead.html",
                                "id": 100000007973475,
                                "asset_id": 100000007973475,
                                "source": "New York Times",
                                "published_date": "2021-09-14",
                                "updated": "2021-09-16 07:55:29",
                                "section": "Arts",
                                "subsection": "Television",
                                "nytdsection": "arts",
                                "adx_keywords": "Deaths (Obituaries);Comedy and Humor;Television;Macdonald, Norm",
                                "column": null,
                                "byline": "By Neil Genzlinger",
                                "type": "Article",
                                "title": "Norm Macdonald, ‘Saturday Night Live’ Comedian, Dies at 61",
                                "abstract": "Acerbic and sometimes controversial, he became familiar to millions as the show’s “Weekend Update” anchor from 1994 to 1998.",
                                "des_facet": [
                                    "Deaths (Obituaries)",
                                    "Comedy and Humor",
                                    "Television"
                                ],
                                "org_facet": [],
                                "per_facet": [
                                    "Macdonald, Norm"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "The comedian Norm Macdonald in 2011.",
                                        "copyright": "Michael Nagle for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/14/obituaries/14macdonald-1/14macdonald-1-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/14/obituaries/14macdonald-1/14macdonald-1-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/14/obituaries/14macdonald-1/14macdonald-1-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/895ba50b-2d0c-5547-934f-660111440956",
                                "url": "https://www.nytimes.com/2021/09/13/health/women-doctors-infertility.html",
                                "id": 100000006963363,
                                "asset_id": 100000006963363,
                                "source": "New York Times",
                                "published_date": "2021-09-13",
                                "updated": "2021-09-13 22:42:34",
                                "section": "Health",
                                "subsection": "",
                                "nytdsection": "health",
                                "adx_keywords": "Infertility;Women and Girls;Doctors;Egg Donation and Freezing;In Vitro Fertilization;Surgery and Surgeons;Medical Schools;Anxiety and Stress;your-feed-science;your-feed-health;Work-Life Balance;Minnesota",
                                "column": null,
                                "byline": "By Jacqueline Mroz",
                                "type": "Article",
                                "title": "A Medical Career, at a Cost: Infertility",
                                "abstract": "Physicians are raising awareness of the reproductive toll that work stress, long hours, sleep deprivation and years of training can exact.",
                                "des_facet": [
                                    "Infertility",
                                    "Women and Girls",
                                    "Doctors",
                                    "Egg Donation and Freezing",
                                    "In Vitro Fertilization",
                                    "Surgery and Surgeons",
                                    "Medical Schools",
                                    "Anxiety and Stress",
                                    "your-feed-science",
                                    "your-feed-health",
                                    "Work-Life Balance"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [
                                    "Minnesota"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Dr. Ariela Marshall, a hematologist at the Mayo Clinic, outside the hospital in Rochester, Minn. One in four female physicians who tries to have a baby is diagnosed with infertility, twice the rate for the general public.",
                                        "copyright": "Jenn Ackerman for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/14/science/00SCI-DOCTORS-INFERTILITY-1/00SCI-DOCTORS-INFERTILITY-1-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/14/science/00SCI-DOCTORS-INFERTILITY-1/00SCI-DOCTORS-INFERTILITY-1-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/14/science/00SCI-DOCTORS-INFERTILITY-1/00SCI-DOCTORS-INFERTILITY-1-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/77186de8-6e72-5be8-860b-87311aaa19e1",
                                "url": "https://www.nytimes.com/2021/09/13/science/colossal-woolly-mammoth-DNA.html",
                                "id": 100000007963617,
                                "asset_id": 100000007963617,
                                "source": "New York Times",
                                "published_date": "2021-09-13",
                                "updated": "2021-09-15 09:03:58",
                                "section": "Science",
                                "subsection": "",
                                "nytdsection": "science",
                                "adx_keywords": "Mammoths (Animals);Genetics and Heredity;Endangered and Extinct Species;Elephants;Cloning;Paleontology;Genetic Engineering;your-feed-science;Church, George M;Colossal Laboratories and Biosciences",
                                "column": null,
                                "byline": "By Carl Zimmer",
                                "type": "Article",
                                "title": "A New Company With a Wild Mission: Bring Back the Woolly Mammoth",
                                "abstract": "With $15 million in private funding, Colossal aims to bring thousands of woolly mammoths back to Siberia. Some scientists are deeply skeptical that will happen.",
                                "des_facet": [
                                    "Mammoths (Animals)",
                                    "Genetics and Heredity",
                                    "Endangered and Extinct Species",
                                    "Elephants",
                                    "Cloning",
                                    "Paleontology",
                                    "Genetic Engineering",
                                    "your-feed-science"
                                ],
                                "org_facet": [
                                    "Colossal Laboratories and Biosciences"
                                ],
                                "per_facet": [
                                    "Church, George M"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "An illustration of a woolly mammoth, a species that lived in the Arctic and died out at the end of the Pleistocene.",
                                        "copyright": "Warren Photographic / Science Source",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/13/science/13SCI-mammoth-3/13SCI-mammoth-3-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/13/science/13SCI-mammoth-3/13SCI-mammoth-3-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/13/science/13SCI-mammoth-3/13SCI-mammoth-3-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/ac950d9b-ebe2-58e2-af22-c6f00de9fbb5",
                                "url": "https://www.nytimes.com/2021/09/06/arts/michael-k-williams-dead.html",
                                "id": 100000007958619,
                                "asset_id": 100000007958619,
                                "source": "New York Times",
                                "published_date": "2021-09-06",
                                "updated": "2021-09-08 12:03:41",
                                "section": "Arts",
                                "subsection": "",
                                "nytdsection": "arts",
                                "adx_keywords": "Deaths (Obituaries);Television;Actors and Actresses;Williams, Michael Kenneth",
                                "column": null,
                                "byline": "By Julia Jacobs, Annie Correal, Matthew Haag and Jeremy Egner",
                                "type": "Article",
                                "title": "Michael K. Williams, Omar From ‘The Wire,’ Is Dead at 54",
                                "abstract": "Mr. Williams, who also starred in “Boardwalk Empire” and “Lovecraft Country,” was best known for his role as Omar Little in the David Simon HBO series.",
                                "des_facet": [
                                    "Deaths (Obituaries)",
                                    "Television",
                                    "Actors and Actresses"
                                ],
                                "org_facet": [],
                                "per_facet": [
                                    "Williams, Michael Kenneth"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Michael K. Williams at the Nostrand Avenue basketball court in the Flatbush neighborhood of Brooklyn in 2017. His work frequently examined the intersection of race, masculinity, crime and institutional failure.",
                                        "copyright": "Demetrius Freeman for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/07/obituaries/07michaelwilliams-obit1-sub/07michaelwilliams-obit1-sub-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/07/obituaries/07michaelwilliams-obit1-sub/07michaelwilliams-obit1-sub-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/07/obituaries/07michaelwilliams-obit1-sub/07michaelwilliams-obit1-sub-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/07c74690-addb-546d-9615-a74231f9dace",
                                "url": "https://www.nytimes.com/2021/09/10/opinion/politics/biden-vaccine-mandate.html",
                                "id": 100000007965423,
                                "asset_id": 100000007965423,
                                "source": "New York Times",
                                "published_date": "2021-09-10",
                                "updated": "2021-09-11 13:55:27",
                                "section": "Opinion",
                                "subsection": "Opinion | Politics",
                                "nytdsection": "opinion",
                                "adx_keywords": "Coronavirus (2019-nCoV);Vaccination and Immunization;United States Politics and Government;Disease Rates;Biden, Joseph R Jr;Centers for Disease Control and Prevention;Occupational Safety and Health Administration;United States",
                                "column": null,
                                "byline": "By Robby Soave",
                                "type": "Article",
                                "title": "Biden’s Vaccine Mandate Is a Big Mistake",
                                "abstract": "Vaccines work. But a mandate by the federal executive is an overreach that may backfire.",
                                "des_facet": [
                                    "Coronavirus (2019-nCoV)",
                                    "Vaccination and Immunization",
                                    "United States Politics and Government",
                                    "Disease Rates"
                                ],
                                "org_facet": [
                                    "Centers for Disease Control and Prevention",
                                    "Occupational Safety and Health Administration"
                                ],
                                "per_facet": [
                                    "Biden, Joseph R Jr"
                                ],
                                "geo_facet": [
                                    "United States"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": " ",
                                        "copyright": "Ringo Chiu/Agence France-Presse, via Getty Images",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/10/opinion/10soave/merlin_193882794_b38baa80-257c-40c8-a1b3-1eee73a1d720-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/10/opinion/10soave/merlin_193882794_b38baa80-257c-40c8-a1b3-1eee73a1d720-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/10/opinion/10soave/merlin_193882794_b38baa80-257c-40c8-a1b3-1eee73a1d720-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/ee724f43-8d5e-58ee-8a56-eed27a45909c",
                                "url": "https://www.nytimes.com/2021/09/08/magazine/egg-rice-recipe.html",
                                "id": 100000007947406,
                                "asset_id": 100000007947406,
                                "source": "New York Times",
                                "published_date": "2021-09-08",
                                "updated": "2021-09-11 00:45:21",
                                "section": "Magazine",
                                "subsection": "",
                                "nytdsection": "magazine",
                                "adx_keywords": "Eggs;Rice;Cooking and Cookbooks;Recipes",
                                "column": null,
                                "byline": "By Eric Kim",
                                "type": "Article",
                                "title": "The Simple Perfection of Fried Eggs and White Rice",
                                "abstract": "The great thing about egg rice is that it’s hardly cooking. If you can fry an egg, then you can make egg rice.",
                                "des_facet": [
                                    "Eggs",
                                    "Rice",
                                    "Cooking and Cookbooks",
                                    "Recipes"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "",
                                        "copyright": "Ryan Liebe for The New York Times. Food stylist: Maggie Ruggiero. Prop stylist: Sophia Pappas.",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/12/magazine/12mag-Eat/12mag-Eat-thumbStandard-v3.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/12/magazine/12mag-Eat/12mag-Eat-mediumThreeByTwo210-v3.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/09/12/magazine/12mag-Eat/12mag-Eat-mediumThreeByTwo440-v3.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            }
                        ]
                    }
                    """

