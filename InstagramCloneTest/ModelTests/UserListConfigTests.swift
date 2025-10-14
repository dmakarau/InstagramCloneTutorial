//
//  UserListConfigTests.swift
//  InstagramCloneTest
//
//  Created by Denis Makarau on 14.10.25.
//

import Testing
import Foundation
@testable import InstagramCloneTutorial

@Suite("UserListConfig Tests")
struct UserListConfigTests {

    // MARK: - Navigation Title Tests

    @Test("Followers case returns correct navigation title")
    func testFollowersNavigationTitle() {
        let config = UserListConfig.followers(uid: "test-uid")
        #expect(config.navigationTitle == "Followers")
    }

    @Test("Following case returns correct navigation title")
    func testFollowingNavigationTitle() {
        let config = UserListConfig.following(uid: "test-uid")
        #expect(config.navigationTitle == "Following")
    }

    @Test("Likes case returns correct navigation title")
    func testLikesNavigationTitle() {
        let config = UserListConfig.likes(postId: "test-post-id")
        #expect(config.navigationTitle == "Likes")
    }

    @Test("Explore case returns correct navigation title")
    func testExploreNavigationTitle() {
        let config = UserListConfig.explore
        #expect(config.navigationTitle == "Explore")
    }

    // MARK: - Hashable Tests

    @Test("Two followers cases with same UID are equal")
    func testFollowersEquality() {
        let config1 = UserListConfig.followers(uid: "user-123")
        let config2 = UserListConfig.followers(uid: "user-123")

        #expect(config1 == config2)
    }

    @Test("Two followers cases with different UIDs are not equal")
    func testFollowersInequality() {
        let config1 = UserListConfig.followers(uid: "user-123")
        let config2 = UserListConfig.followers(uid: "user-456")

        #expect(config1 != config2)
    }

    @Test("Two following cases with same UID are equal")
    func testFollowingEquality() {
        let config1 = UserListConfig.following(uid: "user-123")
        let config2 = UserListConfig.following(uid: "user-123")

        #expect(config1 == config2)
    }

    @Test("Two following cases with different UIDs are not equal")
    func testFollowingInequality() {
        let config1 = UserListConfig.following(uid: "user-123")
        let config2 = UserListConfig.following(uid: "user-456")

        #expect(config1 != config2)
    }

    @Test("Two likes cases with same postId are equal")
    func testLikesEquality() {
        let config1 = UserListConfig.likes(postId: "post-123")
        let config2 = UserListConfig.likes(postId: "post-123")

        #expect(config1 == config2)
    }

    @Test("Two likes cases with different postIds are not equal")
    func testLikesInequality() {
        let config1 = UserListConfig.likes(postId: "post-123")
        let config2 = UserListConfig.likes(postId: "post-456")

        #expect(config1 != config2)
    }

    @Test("Two explore cases are equal")
    func testExploreEquality() {
        let config1 = UserListConfig.explore
        let config2 = UserListConfig.explore

        #expect(config1 == config2)
    }

    @Test("Different enum cases are not equal")
    func testDifferentCasesInequality() {
        let followers = UserListConfig.followers(uid: "user-123")
        let following = UserListConfig.following(uid: "user-123")
        let likes = UserListConfig.likes(postId: "post-123")
        let explore = UserListConfig.explore

        #expect(followers != following)
        #expect(followers != likes)
        #expect(followers != explore)
        #expect(following != likes)
        #expect(following != explore)
        #expect(likes != explore)
    }

    // MARK: - Set Usage Tests

    @Test("UserListConfig can be used in Set")
    func testUserListConfigInSet() {
        let config1 = UserListConfig.followers(uid: "user-123")
        let config2 = UserListConfig.following(uid: "user-456")
        let config3 = UserListConfig.followers(uid: "user-123") // Duplicate
        let config4 = UserListConfig.explore

        let configSet: Set<UserListConfig> = [config1, config2, config3, config4]

        // config1 and config3 are duplicates, so set should have 3 items
        #expect(configSet.count == 3)
        #expect(configSet.contains(config1))
        #expect(configSet.contains(config2))
        #expect(configSet.contains(config4))
    }

    @Test("UserListConfig can be used as Dictionary key")
    func testUserListConfigAsDictionaryKey() {
        var configDict: [UserListConfig: String] = [:]

        configDict[.followers(uid: "user-123")] = "Followers List"
        configDict[.following(uid: "user-456")] = "Following List"
        configDict[.likes(postId: "post-789")] = "Likes List"
        configDict[.explore] = "Explore List"

        #expect(configDict.count == 4)
        #expect(configDict[.followers(uid: "user-123")] == "Followers List")
        #expect(configDict[.explore] == "Explore List")
    }

    // MARK: - Associated Values Tests

    @Test("Followers case stores correct UID")
    func testFollowersAssociatedValue() {
        let testUID = "test-user-123"
        let config = UserListConfig.followers(uid: testUID)

        // Verify by pattern matching
        switch config {
        case .followers(let uid):
            #expect(uid == testUID)
        default:
            Issue.record("Expected followers case")
        }
    }

    @Test("Following case stores correct UID")
    func testFollowingAssociatedValue() {
        let testUID = "test-user-456"
        let config = UserListConfig.following(uid: testUID)

        switch config {
        case .following(let uid):
            #expect(uid == testUID)
        default:
            Issue.record("Expected following case")
        }
    }

    @Test("Likes case stores correct postId")
    func testLikesAssociatedValue() {
        let testPostId = "test-post-789"
        let config = UserListConfig.likes(postId: testPostId)

        switch config {
        case .likes(let postId):
            #expect(postId == testPostId)
        default:
            Issue.record("Expected likes case")
        }
    }

    @Test("Explore case has no associated values")
    func testExploreNoAssociatedValue() {
        let config = UserListConfig.explore

        switch config {
        case .explore:
            // Success - explore case matched
            #expect(Bool(true))
        default:
            Issue.record("Expected explore case")
        }
    }

    // MARK: - Switch Statement Exhaustiveness Test

    @Test("All cases can be handled in switch statement")
    func testSwitchExhaustiveness() {
        let configs: [UserListConfig] = [
            .followers(uid: "user-1"),
            .following(uid: "user-2"),
            .likes(postId: "post-1"),
            .explore
        ]

        for config in configs {
            var caseHandled = false

            switch config {
            case .followers:
                caseHandled = true
            case .following:
                caseHandled = true
            case .likes:
                caseHandled = true
            case .explore:
                caseHandled = true
            }

            #expect(caseHandled)
        }
    }

    // MARK: - Navigation Title Uniqueness Test

    @Test("All navigation titles are unique")
    func testNavigationTitlesUniqueness() {
        let titles: Set<String> = [
            UserListConfig.followers(uid: "uid").navigationTitle,
            UserListConfig.following(uid: "uid").navigationTitle,
            UserListConfig.likes(postId: "postId").navigationTitle,
            UserListConfig.explore.navigationTitle
        ]

        // All 4 titles should be unique
        #expect(titles.count == 4)
    }

    @Test("Navigation titles are not empty")
    func testNavigationTitlesNotEmpty() {
        let configs: [UserListConfig] = [
            .followers(uid: "uid"),
            .following(uid: "uid"),
            .likes(postId: "postId"),
            .explore
        ]

        for config in configs {
            #expect(!config.navigationTitle.isEmpty)
        }
    }

    // MARK: - Hash Value Tests

    @Test("Same configurations produce same hash values")
    func testHashValueConsistency() {
        let config1 = UserListConfig.followers(uid: "user-123")
        let config2 = UserListConfig.followers(uid: "user-123")

        var hasher1 = Hasher()
        var hasher2 = Hasher()

        config1.hash(into: &hasher1)
        config2.hash(into: &hasher2)

        #expect(hasher1.finalize() == hasher2.finalize())
    }

    @Test("Different configurations produce different hash values")
    func testHashValueDifference() {
        let config1 = UserListConfig.followers(uid: "user-123")
        let config2 = UserListConfig.following(uid: "user-123")

        var hasher1 = Hasher()
        var hasher2 = Hasher()

        config1.hash(into: &hasher1)
        config2.hash(into: &hasher2)

        // Hash values should be different for different cases
        #expect(hasher1.finalize() != hasher2.finalize())
    }

    // MARK: - Real-World Usage Scenarios

    @Test("Can create config for viewing user's followers")
    func testViewingFollowersScenario() {
        let userId = "current-user-id"
        let config = UserListConfig.followers(uid: userId)

        #expect(config.navigationTitle == "Followers")

        if case .followers(let uid) = config {
            #expect(uid == userId)
        } else {
            Issue.record("Config should be followers case")
        }
    }

    @Test("Can create config for viewing post likes")
    func testViewingPostLikesScenario() {
        let postId = "trending-post-123"
        let config = UserListConfig.likes(postId: postId)

        #expect(config.navigationTitle == "Likes")

        if case .likes(let id) = config {
            #expect(id == postId)
        } else {
            Issue.record("Config should be likes case")
        }
    }

    @Test("Can create config for explore view")
    func testExploreViewScenario() {
        let config = UserListConfig.explore

        #expect(config.navigationTitle == "Explore")

        // Verify it's the explore case
        if case .explore = config {
            #expect(Bool(true))
        } else {
            Issue.record("Config should be explore case")
        }
    }
}
