//  VKNewsFeed

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedService?
    
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
            
        case .getNewsfeed:
            service?.getFeed(completion: { [weak self] (revealedPostIds, feed) in
                guard let self = self else { return }
                self.presenter?.presentData(response: .presentNewsfeed(feed: feed, revealdedPostIds: revealedPostIds))
            })
        case .getUser:
            service?.getUser(completion: { [weak self] (user) in
                guard let self = self else { return }
                self.presenter?.presentData(response: .presentUserInfo(user: user))
            })
        case .revealPostIds(let postId):
            self.service?.revealPostIds(postId: postId, completion: { [weak self] (revealdedPostIds, feed) in
                guard let self = self else { return }
                self.presenter?.presentData(response: .presentNewsfeed(feed: feed, revealdedPostIds: revealdedPostIds))
            })
        case .getNextBatch:
            service?.getNextBatch(completion: { (revealedPostIds, feed) in
                self.presenter?.presentData(response: .presentNewsfeed(feed: feed, revealdedPostIds: revealedPostIds))
            })
        }
        
    }
}
