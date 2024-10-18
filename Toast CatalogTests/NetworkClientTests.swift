import XCTest
@testable import Toast_Catalog

class NetworkClientTests: XCTestCase {

    func testEndpoint() {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let expectedResponse = try! jsonDecoder.decode([Item].self, from: expectedResponseData)

        let networkClient = NetworkClient()
        networkClient.getItems { result in
            guard case let .success(orders) = result else {
                XCTFail()
                return
            }
            XCTAssertEqual(expectedResponse, orders)
        }
    }

}

private let expectedResponseData = """
[{
    "name": "Avocado Toast",
    "price": "5.99",
    "id": 1,
    "currency": "EUR",
    "last_sold": "2020-11-28T15:14:22Z"
  },
  {
    "name": "Bacon Toast",
    "id": 2,
    "price": "1.99",
    "currency": "EUR",
    "last_sold": "2021-01-30T02:24:04Z"
  },
  {
    "name": "Crunchy Toast",
    "id": 3,
    "price": "0.99",
    "currency": "EUR",
    "last_sold": "2021-03-17T03:45:47Z"
  }
]
""".data(using: .utf8)!

