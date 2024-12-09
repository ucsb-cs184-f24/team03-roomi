//
//  RedisManager.swift
//  Roomi
//
//  Created by Ryan Vo on 12/8/24.
//


import Foundation
import RediStack
import NIO

final class RedisManager {
    static let shared = RedisManager()
    private var connection: RedisConnection?
    private let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)

    private init() {
        Task {
            await initializeConnection()
        }
    }

    /// Initializes the Redis connection
    private func initializeConnection() async {
        do {
            connection = try await RedisConnection
                .make(configuration: .init(
                    hostname: "redis-13693.c60.us-west-1-2.ec2.redns.redis-cloud.com",
                    port: 13693,
                    password: "pDJysBaqU5TOUr6PRJFTVeBO6RCK0drb"
                ), boundEventLoop: eventLoopGroup.next())
                .get() // Resolve EventLoopFuture
            print("Redis connection established successfully")
        } catch {
            print("Failed to connect to Redis: \(error.localizedDescription)")
        }
    }

    /// Returns the current Redis connection, reconnecting if necessary
    func getConnection() -> RedisConnection? {
        if connection == nil {
            Task {
                await initializeConnection()
            }
        }
        return connection
    }

    /// Fetches Base64 image string from Redis for a given key
    func fetchBase64Image(for key: String, completion: @escaping (Result<String?, Error>) -> Void) {
        guard let connection = getConnection() else {
            completion(.failure(NSError(domain: "RedisConnection", code: -1, userInfo: [NSLocalizedDescriptionKey: "Redis connection is not available."])))
            return
        }

        // Use `.whenComplete` to handle the EventLoopFuture directly
        connection.get(RedisKey(key), as: String.self).whenComplete { result in
            switch result {
            case .success(let base64String):
                completion(.success(base64String))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    /// Closes the Redis connection
    func closeConnection() {
        connection?.close()
        connection = nil
        print("Redis connection closed")
    }

    deinit {
        try? eventLoopGroup.syncShutdownGracefully()
    }
}