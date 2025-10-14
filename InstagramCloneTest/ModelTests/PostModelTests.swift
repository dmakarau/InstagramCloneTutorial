//
//  PostModelTests.swift
//  InstagramCloneTest
//
//  Created by Denis Makarau on 14.10.25.
//

import Testing
import Foundation
import Firebase
@testable import InstagramCloneTutorial

@Suite("Post Model Tests")
struct PostModelTests {

    // MARK: - Initialization Tests

    @Test("Post initializes with all properties")
    func testPostInitialization() {
        let timestamp = Timestamp()
        let mockUser = User(
            id: "user-123",
            username: "testuser",
            email: "test@example.com"
        )

        let post = Post(
            id: "post-123",
            ownerId: "user-123",
            caption: "Test caption",
            likes: 42,
            imageUrl: "https://example.com/image.jpg",
            timestamp: timestamp,
            user: mockUser
        )

        #expect(post.id == "post-123")
        #expect(post.ownerId == "user-123")
        #expect(post.caption == "Test caption")
        #expect(post.likes == 42)
        #expect(post.imageUrl == "https://example.com/image.jpg")
        #expect(post.timestamp == timestamp)
        #expect(post.user?.id == "user-123")
    }

    @Test("Post initializes with nil user")
    func testPostInitializationWithNilUser() {
        let timestamp = Timestamp()

        let post = Post(
            id: "post-456",
            ownerId: "owner-456",
            caption: "Caption without user",
            likes: 10,
            imageUrl: "https://example.com/pic.jpg",
            timestamp: timestamp,
            user: nil
        )

        #expect(post.id == "post-456")
        #expect(post.user == nil)
    }

    @Test("Post initializes with default didLike as false")
    func testDefaultDidLike() {
        let post = Post(
            id: "post-789",
            ownerId: "owner-789",
            caption: "Test",
            likes: 0,
            imageUrl: "url",
            timestamp: Timestamp()
        )

        #expect(post.didLike == false)
    }

    @Test("Post initializes with zero likes")
    func testPostWithZeroLikes() {
        let post = Post(
            id: "post-zero",
            ownerId: "owner-zero",
            caption: "New post",
            likes: 0,
            imageUrl: "url",
            timestamp: Timestamp()
        )

        #expect(post.likes == 0)
    }

    @Test("Post likes can be mutated")
    func testPostLikesMutability() {
        var post = Post(
            id: "post-mut",
            ownerId: "owner-mut",
            caption: "Mutable likes test",
            likes: 10,
            imageUrl: "url",
            timestamp: Timestamp()
        )

        post.likes = 20
        #expect(post.likes == 20)

        post.likes += 5
        #expect(post.likes == 25)
    }

    @Test("Post didLike can be mutated")
    func testPostDidLikeMutability() {
        var post = Post(
            id: "post-like",
            ownerId: "owner-like",
            caption: "Like test",
            likes: 10,
            imageUrl: "url",
            timestamp: Timestamp()
        )

        #expect(post.didLike == false)

        post.didLike = true
        #expect(post.didLike == true)

        post.didLike = nil
        #expect(post.didLike == nil)
    }

    // MARK: - Codable Tests

    @Test("Post encodes to JSON correctly")
    func testPostEncoding() throws {
        let timestamp = Timestamp(date: Date(timeIntervalSince1970: 1000000))
        let post = Post(
            id: "encode-post",
            ownerId: "encode-owner",
            caption: "Encoding test",
            likes: 100,
            imageUrl: "https://example.com/encode.jpg",
            timestamp: timestamp
        )

        let encoder = JSONEncoder()
        let data = try encoder.encode(post)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]

        #expect(json?["id"] as? String == "encode-post")
        #expect(json?["ownerId"] as? String == "encode-owner")
        #expect(json?["caption"] as? String == "Encoding test")
        #expect(json?["likes"] as? Int == 100)
        #expect(json?["imageUrl"] as? String == "https://example.com/encode.jpg")
    }

    @Test("Post decodes from JSON correctly")
    func testPostDecoding() throws {
        let json = """
        {
            "id": "decoded-post",
            "ownerId": "decoded-owner",
            "caption": "Decoded caption",
            "likes": 250,
            "imageUrl": "https://example.com/decoded.jpg",
            "timestamp": {
                "seconds": 1000000,
                "nanoseconds": 0
            }
        }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let post = try decoder.decode(Post.self, from: data)

        #expect(post.id == "decoded-post")
        #expect(post.ownerId == "decoded-owner")
        #expect(post.caption == "Decoded caption")
        #expect(post.likes == 250)
        #expect(post.imageUrl == "https://example.com/decoded.jpg")
    }

    @Test("Post decodes with nested User")
    func testPostDecodingWithUser() throws {
        let json = """
        {
            "id": "post-with-user",
            "ownerId": "owner-123",
            "caption": "Post with user",
            "likes": 50,
            "imageUrl": "https://example.com/image.jpg",
            "timestamp": {
                "seconds": 1000000,
                "nanoseconds": 0
            },
            "user": {
                "id": "user-123",
                "username": "testuser",
                "email": "test@example.com"
            }
        }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let post = try decoder.decode(Post.self, from: data)

        #expect(post.id == "post-with-user")
        #expect(post.user?.id == "user-123")
        #expect(post.user?.username == "testuser")
        #expect(post.user?.email == "test@example.com")
    }

    @Test("Post decodes without optional user")
    func testPostDecodingWithoutUser() throws {
        let json = """
        {
            "id": "post-no-user",
            "ownerId": "owner-456",
            "caption": "No user post",
            "likes": 15,
            "imageUrl": "https://example.com/image.jpg",
            "timestamp": {
                "seconds": 1000000,
                "nanoseconds": 0
            }
        }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let post = try decoder.decode(Post.self, from: data)

        #expect(post.id == "post-no-user")
        #expect(post.user == nil)
    }

    @Test("Post decodes with didLike field")
    func testPostDecodingWithDidLike() throws {
        let json = """
        {
            "id": "post-liked",
            "ownerId": "owner-789",
            "caption": "Liked post",
            "likes": 300,
            "imageUrl": "url",
            "timestamp": {
                "seconds": 1000000,
                "nanoseconds": 0
            },
            "didLike": true
        }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let post = try decoder.decode(Post.self, from: data)

        #expect(post.didLike == true)
    }

    // MARK: - Hashable Tests

    @Test("Posts with identical properties are equal")
    func testPostHashableEquality() {
        let timestamp = Timestamp(date: Date(timeIntervalSince1970: 1000000))
        let user = User(id: "user-1", username: "user1", email: "user1@test.com")

        let post1 = Post(
            id: "same-id",
            ownerId: "owner-1",
            caption: "Same caption",
            likes: 100,
            imageUrl: "https://example.com/image.jpg",
            timestamp: timestamp,
            user: user
        )

        let post2 = Post(
            id: "same-id",
            ownerId: "owner-1",
            caption: "Same caption",
            likes: 100,
            imageUrl: "https://example.com/image.jpg",
            timestamp: timestamp,
            user: user
        )

        #expect(post1 == post2)
    }

    @Test("Posts with different IDs are not equal")
    func testPostHashableInequality() {
        let timestamp = Timestamp()

        let post1 = Post(
            id: "post-1",
            ownerId: "owner-1",
            caption: "Caption",
            likes: 10,
            imageUrl: "url",
            timestamp: timestamp
        )

        let post2 = Post(
            id: "post-2",
            ownerId: "owner-1",
            caption: "Caption",
            likes: 10,
            imageUrl: "url",
            timestamp: timestamp
        )

        #expect(post1 != post2)
    }

    @Test("Posts with same ID but different properties are not equal")
    func testPostHashableInequalityDifferentProperties() {
        let timestamp = Timestamp()

        let post1 = Post(
            id: "same-id",
            ownerId: "owner-1",
            caption: "Caption 1",
            likes: 10,
            imageUrl: "url1",
            timestamp: timestamp
        )

        let post2 = Post(
            id: "same-id",
            ownerId: "owner-1",
            caption: "Caption 2",
            likes: 20,
            imageUrl: "url2",
            timestamp: timestamp
        )

        #expect(post1 != post2)
    }

    @Test("Post can be used in Set")
    func testPostInSet() {
        let timestamp = Timestamp()
        let post1 = Post(id: "post-1", ownerId: "owner", caption: "Caption 1", likes: 10, imageUrl: "url1", timestamp: timestamp)
        let post2 = Post(id: "post-2", ownerId: "owner", caption: "Caption 2", likes: 20, imageUrl: "url2", timestamp: timestamp)
        let post3 = Post(id: "post-1", ownerId: "owner", caption: "Caption 1", likes: 10, imageUrl: "url1", timestamp: timestamp)

        let postSet: Set<Post> = [post1, post2, post3]

        // post1 and post3 are identical
        #expect(postSet.count == 2)
        #expect(postSet.contains(post1))
        #expect(postSet.contains(post2))
    }

    // MARK: - Identifiable Tests

    @Test("Post conforms to Identifiable")
    func testPostIdentifiable() {
        let post = Post(
            id: "identifiable-post",
            ownerId: "owner",
            caption: "Test",
            likes: 0,
            imageUrl: "url",
            timestamp: Timestamp()
        )

        // Identifiable protocol requires an 'id' property
        let identifiableId: String = post.id
        #expect(identifiableId == "identifiable-post")
    }

    // MARK: - Mock Data Tests

    @Test("MOCK_IMAGE_URL is valid")
    func testMockImageUrl() {
        let mockUrl = Post.MOCK_IMAGE_URL

        #expect(!mockUrl.isEmpty)
        #expect(mockUrl.hasPrefix("https://"))
    }

    @Test("MOCK_POSTS array contains posts")
    func testMockPostsCount() {
        let mockPosts = Post.MOCK_POSTS

        #expect(mockPosts.count == 6)
    }

    @Test("MOCK_POSTS have valid properties")
    func testMockPostsValidProperties() {
        let mockPosts = Post.MOCK_POSTS

        for post in mockPosts {
            #expect(!post.id.isEmpty)
            #expect(!post.ownerId.isEmpty)
            #expect(!post.caption.isEmpty)
            #expect(post.likes >= 0)
            #expect(!post.imageUrl.isEmpty)
        }
    }

    @Test("MOCK_POSTS have unique IDs")
    func testMockPostsUniqueIds() {
        let mockPosts = Post.MOCK_POSTS
        let ids = mockPosts.map { $0.id }
        let uniqueIds = Set(ids)

        #expect(ids.count == uniqueIds.count)
    }

    @Test("MOCK_POSTS contain associated users")
    func testMockPostsHaveUsers() {
        let mockPosts = Post.MOCK_POSTS

        for post in mockPosts {
            #expect(post.user != nil)
            #expect(!post.user!.username.isEmpty)
        }
    }

    // MARK: - Edge Case Tests

    @Test("Post with empty caption")
    func testPostWithEmptyCaption() {
        let post = Post(
            id: "empty-caption",
            ownerId: "owner",
            caption: "",
            likes: 5,
            imageUrl: "url",
            timestamp: Timestamp()
        )

        #expect(post.caption.isEmpty)
    }

    @Test("Post with very long caption")
    func testPostWithLongCaption() {
        let longCaption = String(repeating: "a", count: 5000)
        let post = Post(
            id: "long-caption",
            ownerId: "owner",
            caption: longCaption,
            likes: 5,
            imageUrl: "url",
            timestamp: Timestamp()
        )

        #expect(post.caption.count == 5000)
    }

    @Test("Post with large number of likes")
    func testPostWithManyLikes() {
        let post = Post(
            id: "viral-post",
            ownerId: "influencer",
            caption: "Viral content",
            likes: 1_000_000,
            imageUrl: "url",
            timestamp: Timestamp()
        )

        #expect(post.likes == 1_000_000)
    }

    @Test("Post with negative likes should still be stored")
    func testPostWithNegativeLikes() {
        // Although negative likes don't make sense in real app,
        // the model should still handle it as Int allows it
        let post = Post(
            id: "negative-post",
            ownerId: "owner",
            caption: "Test",
            likes: -5,
            imageUrl: "url",
            timestamp: Timestamp()
        )

        #expect(post.likes == -5)
    }

    // MARK: - Real-World Usage Scenarios

    @Test("Incrementing post likes scenario")
    func testIncrementingLikes() {
        var post = Post(
            id: "like-test",
            ownerId: "owner",
            caption: "Like this post",
            likes: 42,
            imageUrl: "url",
            timestamp: Timestamp()
        )

        let initialLikes = post.likes
        post.likes += 1

        #expect(post.likes == initialLikes + 1)
        #expect(post.likes == 43)
    }

    @Test("User likes post scenario")
    func testUserLikesPost() {
        var post = Post(
            id: "like-scenario",
            ownerId: "owner",
            caption: "Double tap to like",
            likes: 100,
            imageUrl: "url",
            timestamp: Timestamp()
        )

        // User hasn't liked the post yet
        #expect(post.didLike == false)

        // User likes the post
        post.didLike = true
        post.likes += 1

        #expect(post.didLike == true)
        #expect(post.likes == 101)
    }

    @Test("User unlikes post scenario")
    func testUserUnlikesPost() {
        var post = Post(
            id: "unlike-scenario",
            ownerId: "owner",
            caption: "Test unlike",
            likes: 100,
            imageUrl: "url",
            timestamp: Timestamp(),
            didLike: true
        )

        #expect(post.didLike == true)
        #expect(post.likes == 100)

        // User unlikes the post
        post.didLike = false
        post.likes -= 1

        #expect(post.didLike == false)
        #expect(post.likes == 99)
    }

    @Test("Post creation with current timestamp")
    func testPostCreationWithCurrentTimestamp() {
        let now = Timestamp()
        let post = Post(
            id: "new-post",
            ownerId: "creator",
            caption: "Just posted!",
            likes: 0,
            imageUrl: "https://example.com/new.jpg",
            timestamp: now
        )

        #expect(post.timestamp == now)
        #expect(post.likes == 0)
    }
}
