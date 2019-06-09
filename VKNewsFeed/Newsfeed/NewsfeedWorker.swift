//  NewsfeedWorker.swift

import UIKit

class NewsfeedService {
    
    
    var authService: AuthService
    var networking: Networking
    var fetcher: DataFetcher
    
    
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    private var newFromInProcess: String?
    
    init() {
        self.authService = AppDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { (user) in
            completion(user)
        }
    }
    
    func getFeed(completion: @escaping ([Int], FeedResponse) -> Void) {
        fetcher.getFeed(nextBatchFrom: nil) { [weak self] (feed) in
            guard let self = self else { return }
            self.feedResponse = feed
            guard let feedResponse = self.feedResponse else { return }
            completion(self.revealedPostIds, feedResponse)
        }
    }
    
    func revealPostIds(postId: Int, completion: @escaping ([Int], FeedResponse) -> Void) {
        revealedPostIds.append(postId)
        guard let feedResponse = self.feedResponse else { return }
        completion(revealedPostIds, feedResponse)
    }
    
    func getNextBatch(completion: @escaping ([Int], FeedResponse) -> Void) {
        newFromInProcess = feedResponse?.nextFrom
        fetcher.getFeed(nextBatchFrom: newFromInProcess) { [weak self] (feed) in
            guard
                let self = self,
                let feedResponse = feed
                else { return }
            
            guard self.feedResponse?.nextFrom != feedResponse.nextFrom else { return }
            
            if self.feedResponse == nil {
                self.feedResponse = feed
            } else {
                self.feedResponse?.items.append(contentsOf: feedResponse.items)
                
                var profiles = feedResponse.profiles
                if let oldProfiles = self.feedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter({ (oldProfile) -> Bool in
                        !feedResponse.profiles.contains(where: { $0.id == oldProfile.id })
                    })
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self.feedResponse?.profiles = profiles
                
                var groups = feedResponse.groups
                if let oldGroups = self.feedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter({ (oldGroup) -> Bool in
                        !feedResponse.groups.contains(where: { $0.id == oldGroup.id })
                    })
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self.feedResponse?.groups = groups
                self.feedResponse?.nextFrom = feedResponse.nextFrom
            }
            
            guard let feedResponce = self.feedResponse else { return }
            
            completion(self.revealedPostIds, feedResponce)
        }
    }
}
