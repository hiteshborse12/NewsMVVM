//
//  MockNewsJson.swift
//  News
//
//  Created by Neosoft on 15/08/22.
//

import Foundation
enum MockNewsJson {
    static let mockJSONResponse:[String:Any] = [
        "status": "ok",
        "totalResults": 2,
        "articles" :[
            [
                "source": [
                    "id": nil,
                    "name": "CNBC"
                ],
                "author": "Hannah Ward-Glenton",
                "title": "Personalized coffees and prestige skincare: Consumers snap up premium products despite cost-of-living crisis - CNBC",
                "description": "Personalized coffees, \"prestige\" skincare and \"elevated\" spreads: companies are focussing on premium products — and consumers seem to love it.",
                "url": "https://www.cnbc.com/2022/08/15/premium-products-take-priority-as-companies-battle-cost-of-living.html",
                "urlToImage": "https://image.cnbcfm.com/api/v1/image/107103080-1660299891076-GettyImages-1406297560.jpg?v=1660300047&w=1920&h=1080",
                "publishedAt": "2022-08-15T05:52:56Z",
                "content": "Personalized coffees, \"prestige\" skincare and \"elevated\" sauces and spreads are just some examples of how companies like Starbucks, Unilever and Kraft Heinz are tilting their focus toward premium pro… [+6096 chars]"
            ],
            [
                "source": [
                    "id": "reuters",
                    "name": "Reuters"
                ],
                "author": "Huw Jones",
                "title": "Asia shares mixed, China cuts rates as data disappoints - Reuters.com",
                "description": "Asian shares were mixed on Monday after China's central bank trimmed key lending rates as a raft of economic data missed forecasts and underlined the need for more stimulus to support the world's second largest economy.",
                "url": "https://www.reuters.com/markets/europe/global-markets-wrapup-1-pix-2022-08-15/",
                "urlToImage": "https://www.reuters.com/resizer/x8K0PQaMBcvCDMlPPBADa14N6N8=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/BCLVP57DJVLZ7L6IV4QTVXAB3E.jpg",
                "publishedAt": "2022-08-15T05:24:00Z",
                "content": "SYDNEY, Aug 15 (Reuters) - Asian shares were mixed on Monday after China's central bank trimmed key lending rates as a raft of economic data missed forecasts and underlined the need for more stimulus… [+4187 chars]"
            ],
        ]
    ]
    static let mockEmptyJSONResponse:[String:Any] = ["status": "ok","totalResults": 0,"articles" :[]]
}
