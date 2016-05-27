//
//  API.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

enum APIError: ErrorType, CustomStringConvertible {
    case InvalidResponse
    case NotFound
    
    var description: String {
        switch self {
        case .InvalidResponse: return "Received an invalid response"
        case .NotFound: return "Requested item was not found"
        }
    }
}

class API {
    //MARK: - Private
    private let network: Network
    
    //MARK: - Lifecycle
    init(network: Network) {
        self.network = network
    }
    
    //MARK: - Public
    func getFriends(success success: ([Friend]) -> Void, failure: (ErrorType) -> Void) {
        let request = NetworkRequest(
            method: .GET,
            url: "http://api.randomuser.me/?results=20"
        )
        self.network.makeRequest(
            request,
            success: { (json: [String: AnyObject]) in
                guard let items = json.getWithKeyPath("results", as: [[String: AnyObject]].self) else {
                    failure(APIError.InvalidResponse)
                    return
                }
                
                let updatedItems = items.map(self.jsonWithInjectedAbout)
                let users = updatedItems.flatMap(Friend.init(json:))
                success(users)
            },
            failure: failure)
    }
    
    //MARK: - Helpers
    private func jsonWithInjectedAbout(json: [String: AnyObject]) -> [String: AnyObject] {
        let lorems = [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vel ante ac odio gravida convallis. Ut faucibus eu nulla eget sollicitudin. Quisque ac erat ut tortor fringilla euismod id non nisl. Maecenas diam elit, ornare accumsan libero ac, hendrerit ullamcorper quam. Aenean in nisi malesuada odio faucibus fermentum. Aliquam erat volutpat. Etiam ut sapien iaculis, venenatis diam at, vehicula mauris. Donec arcu nulla, lobortis eu posuere eu, tincidunt non tortor. Nunc facilisis ex at tristique mattis. Aenean luctus orci felis, non ullamcorper ipsum placerat vulputate. Proin eleifend neque a odio egestas sagittis. Pellentesque malesuada nulla a enim ultricies blandit. Pellentesque commodo nulla et lacus malesuada, at rutrum nunc fermentum.",
            "Praesent bibendum nunc dolor, et iaculis arcu vestibulum nec. Praesent vestibulum eros in metus suscipit, eget sagittis orci bibendum. Duis auctor convallis dignissim. Maecenas sapien nisi, feugiat eu eros lacinia, mattis laoreet ligula. Phasellus porta efficitur sapien sit amet commodo. Suspendisse dictum tincidunt tortor quis bibendum. Curabitur congue viverra vehicula. Curabitur eget diam nec nunc dapibus tincidunt. In at lectus aliquam, dictum ipsum at, convallis sem. Donec volutpat lorem eu mauris semper, viverra iaculis lorem posuere. Maecenas iaculis egestas ante, nec vulputate eros varius sit amet. Nam dapibus massa nunc, viverra pretium metus dignissim in. Nulla nec facilisis nunc. Morbi dictum velit in mi tincidunt pharetra. Aliquam erat volutpat.",
            "Nam consectetur eget est sit amet ornare. Vivamus leo mauris, ornare et ornare eu, aliquam a sapien. Donec ultrices ante nec sapien varius maximus. In hac habitasse platea dictumst. Mauris vitae nisl at purus vestibulum maximus. Proin finibus aliquam nibh id tristique. Quisque hendrerit sit amet erat vel accumsan. Sed ac mi sit amet quam suscipit fringilla. Cras mattis, nulla sed lobortis finibus, ipsum dolor porttitor ipsum, id accumsan eros leo in metus. Sed id magna ut diam viverra viverra. Donec porta gravida fermentum. Vivamus id massa interdum, dapibus augue sit amet, dictum tortor.",
            "Morbi accumsan tortor justo, sit amet pharetra tellus elementum ut. Quisque aliquet tempus congue. Sed ut elementum odio, at porta enim. Suspendisse et mi molestie, viverra nisl non, accumsan tellus. Cras semper, lectus at consequat mollis, enim libero rutrum ipsum, vel pulvinar nulla risus lacinia eros. Cras efficitur, libero ut molestie vulputate, lorem justo commodo est, nec cursus ipsum sem ut augue. Quisque elementum sollicitudin lacus et eleifend. Quisque ac vulputate diam, sollicitudin faucibus odio. Sed sodales porttitor pellentesque. Proin et sapien efficitur, maximus velit ac, auctor ex. Donec iaculis ultricies auctor. Donec tempus tempor sapien, sit amet viverra tortor sodales ut. Ut faucibus magna eu nisi varius, quis maximus velit sodales. Vivamus maximus velit ipsum, eget accumsan lectus auctor non. Nulla sollicitudin tristique auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "Vestibulum tincidunt tincidunt erat, sit amet dictum magna venenatis quis. Nullam quis tristique magna, at pharetra dolor. Quisque ullamcorper iaculis sapien, vitae interdum magna sollicitudin sit amet. Quisque diam nisi, malesuada et nisl vel, vulputate vestibulum ante. Curabitur sit amet neque nunc. Duis euismod mattis tortor, eget lacinia arcu vulputate ut. Nunc quis leo risus. In sollicitudin odio vel neque efficitur varius. Aliquam et convallis risus. Vivamus id tristique nulla. Nulla dolor nulla, cursus ut nisl at, imperdiet dapibus nisi. Mauris luctus ac dolor sit amet sagittis. Vivamus mollis lacinia convallis. Phasellus scelerisque faucibus diam, non auctor risus imperdiet id. Etiam fringilla aliquam nulla, interdum dapibus arcu laoreet et. Cras in eleifend quam."
        ]
        return json.append(["about": lorems.randomElement()])
    }
}
