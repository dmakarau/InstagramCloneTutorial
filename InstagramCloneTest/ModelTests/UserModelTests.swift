//
//  UserModelTests.swift
//  InstagramCloneTest
//
//  Created by Denis Makarau on 14.10.25.
//

import Testing
import Foundation
@testable import InstagramCloneTutorial

@Suite("User Model Tests")
struct UserModelTests {

    // MARK: - Initialization Tests

    @Test("User initializes with required properties")
    func testUserInitialization() {
        let user = User(
            id: "test-id-123",
            username: "testuser",
            profileImageUrl: "https://example.com/image.jpg",
            fullname: "Test User",
            bio: "Test bio",
            email: "test@example.com"
        )

        #expect(user.id == "test-id-123")
        #expect(user.username == "testuser")
        #expect(user.profileImageUrl == "https://example.com/image.jpg")
        #expect(user.fullname == "Test User")
        #expect(user.bio == "Test bio")
        #expect(user.email == "test@example.com")
    }

    @Test("User initializes with optional properties as nil")
    func testUserWithOptionalNil() {
        let user = User(
            id: "test-id",
            username: "user",
            profileImageUrl: nil,
            fullname: nil,
            bio: nil,
            email: "user@test.com"
        )

        #expect(user.profileImageUrl == nil)
        #expect(user.fullname == nil)
        #expect(user.bio == nil)
    }

    @Test("User initializes with default isFollowed as false")
    func testDefaultIsFollowed() {
        let user = User(
            id: "test-id",
            username: "user",
            email: "test@example.com"
        )

        #expect(user.isFollowed == false)
    }

    @Test("User initializes with stats")
    func testUserWithStats() {
        let stats = UserStats(followingCount: 10, followersCount: 20, postsCount: 5)
        var user = User(
            id: "test-id",
            username: "user",
            email: "test@example.com"
        )
        user.stats = stats

        #expect(user.stats?.followingCount == 10)
        #expect(user.stats?.followersCount == 20)
        #expect(user.stats?.postsCount == 5)
    }

    // MARK: - Codable Tests

    @Test("User encodes to JSON correctly")
    func testUserEncoding() throws {
        let user = User(
            id: "test-id",
            username: "testuser",
            profileImageUrl: "https://example.com/image.jpg",
            fullname: "Test User",
            bio: "Bio",
            email: "test@example.com"
        )

        let encoder = JSONEncoder()
        let data = try encoder.encode(user)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]

        #expect(json?["id"] as? String == "test-id")
        #expect(json?["username"] as? String == "testuser")
        #expect(json?["email"] as? String == "test@example.com")
        #expect(json?["fullname"] as? String == "Test User")
    }

    @Test("User decodes from JSON correctly")
    func testUserDecoding() throws {
        let json = """
        {
            "id": "decoded-id",
            "username": "decodeduser",
            "email": "decoded@test.com",
            "profileImageUrl": "https://example.com/pic.jpg",
            "fullname": "Decoded User",
            "bio": "Decoded bio"
        }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: data)

        #expect(user.id == "decoded-id")
        #expect(user.username == "decodeduser")
        #expect(user.email == "decoded@test.com")
        #expect(user.profileImageUrl == "https://example.com/pic.jpg")
        #expect(user.fullname == "Decoded User")
        #expect(user.bio == "Decoded bio")
    }

    @Test("User decodes with missing optional fields")
    func testUserDecodingWithMissingOptionals() throws {
        let json = """
        {
            "id": "minimal-id",
            "username": "minimal",
            "email": "minimal@test.com"
        }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: data)

        #expect(user.id == "minimal-id")
        #expect(user.username == "minimal")
        #expect(user.email == "minimal@test.com")
        #expect(user.profileImageUrl == nil)
        #expect(user.fullname == nil)
        #expect(user.bio == nil)
    }

    @Test("User decodes with stats")
    func testUserDecodingWithStats() throws {
        let json = """
        {
            "id": "stats-id",
            "username": "statsuser",
            "email": "stats@test.com",
            "stats": {
                "followingCount": 15,
                "followersCount": 25,
                "postsCount": 8
            }
        }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: data)

        #expect(user.stats?.followingCount == 15)
        #expect(user.stats?.followersCount == 25)
        #expect(user.stats?.postsCount == 8)
    }

    // MARK: - Hashable Tests

    @Test("Users with identical properties are equal")
    func testUserHashableEquality() {
        let user1 = User(
            id: "same-id",
            username: "testuser",
            profileImageUrl: "https://example.com/pic.jpg",
            fullname: "Test User",
            bio: "Test bio",
            email: "test@example.com"
        )

        let user2 = User(
            id: "same-id",
            username: "testuser",
            profileImageUrl: "https://example.com/pic.jpg",
            fullname: "Test User",
            bio: "Test bio",
            email: "test@example.com"
        )

        #expect(user1 == user2)
    }

    @Test("Users with different IDs are not equal")
    func testUserHashableInequality() {
        let user1 = User(
            id: "id-1",
            username: "user",
            email: "user@test.com"
        )

        let user2 = User(
            id: "id-2",
            username: "user",
            email: "user@test.com"
        )

        #expect(user1 != user2)
    }

    @Test("Users with same ID but different properties are not equal")
    func testUserHashableInequalityDifferentProperties() {
        let user1 = User(
            id: "same-id",
            username: "user1",
            email: "user1@test.com"
        )

        let user2 = User(
            id: "same-id",
            username: "user2",
            email: "user2@test.com"
        )

        // Even with same ID, different properties mean not equal
        #expect(user1 != user2)
    }

    @Test("User can be used in Set")
    func testUserInSet() {
        let user1 = User(id: "id-1", username: "user1", email: "user1@test.com")
        let user2 = User(id: "id-2", username: "user2", email: "user2@test.com")
        let user3 = User(id: "id-1", username: "user1", email: "user1@test.com") // Exact duplicate

        let userSet: Set<User> = [user1, user2, user3]

        // user1 and user3 are identical, so set should only have 2 users
        #expect(userSet.count == 2)
        #expect(userSet.contains(user1))
        #expect(userSet.contains(user2))
    }

    // MARK: - Mock Data Tests

    @Test("Mock users are valid")
    func testMockUsers() {
        let mockUsers = User.MOCK_USERS

        #expect(mockUsers.count == 5)
        #expect(mockUsers[0].username == "batman")
        #expect(mockUsers[1].username == "venom")
        #expect(mockUsers[2].username == "ironman")
        #expect(mockUsers[3].username == "blackpanther")
        #expect(mockUsers[4].username == "spiderman")
    }

    @Test("Mock users have unique IDs")
    func testMockUsersUniqueIds() {
        let mockUsers = User.MOCK_USERS
        let ids = mockUsers.map { $0.id }
        let uniqueIds = Set(ids)

        #expect(ids.count == uniqueIds.count)
    }

    @Test("Mock users have required fields")
    func testMockUsersRequiredFields() {
        let mockUsers = User.MOCK_USERS

        for user in mockUsers {
            #expect(!user.id.isEmpty)
            #expect(!user.username.isEmpty)
            #expect(!user.email.isEmpty)
        }
    }
}

// MARK: - UserStats Tests

@Suite("UserStats Tests")
struct UserStatsTests {

    @Test("UserStats initializes correctly")
    func testUserStatsInitialization() {
        let stats = UserStats(
            followingCount: 100,
            followersCount: 200,
            postsCount: 50
        )

        #expect(stats.followingCount == 100)
        #expect(stats.followersCount == 200)
        #expect(stats.postsCount == 50)
    }

    @Test("UserStats encodes to JSON correctly")
    func testUserStatsEncoding() throws {
        let stats = UserStats(
            followingCount: 10,
            followersCount: 20,
            postsCount: 5
        )

        let encoder = JSONEncoder()
        let data = try encoder.encode(stats)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]

        #expect(json?["followingCount"] as? Int == 10)
        #expect(json?["followersCount"] as? Int == 20)
        #expect(json?["postsCount"] as? Int == 5)
    }

    @Test("UserStats decodes from JSON correctly")
    func testUserStatsDecoding() throws {
        let json = """
        {
            "followingCount": 30,
            "followersCount": 40,
            "postsCount": 12
        }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let stats = try decoder.decode(UserStats.self, from: data)

        #expect(stats.followingCount == 30)
        #expect(stats.followersCount == 40)
        #expect(stats.postsCount == 12)
    }

    @Test("UserStats with zero counts")
    func testUserStatsZeroCounts() {
        let stats = UserStats(
            followingCount: 0,
            followersCount: 0,
            postsCount: 0
        )

        #expect(stats.followingCount == 0)
        #expect(stats.followersCount == 0)
        #expect(stats.postsCount == 0)
    }

    @Test("UserStats are equal when values match")
    func testUserStatsEquality() {
        let stats1 = UserStats(followingCount: 10, followersCount: 20, postsCount: 5)
        let stats2 = UserStats(followingCount: 10, followersCount: 20, postsCount: 5)

        #expect(stats1 == stats2)
    }

    @Test("UserStats are not equal when values differ")
    func testUserStatsInequality() {
        let stats1 = UserStats(followingCount: 10, followersCount: 20, postsCount: 5)
        let stats2 = UserStats(followingCount: 15, followersCount: 20, postsCount: 5)

        #expect(stats1 != stats2)
    }
}
