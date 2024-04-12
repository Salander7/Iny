//
//  ItemManager.swift
//  Iny
//
//  Created by Deniz Dilbilir on 08/04/2024.
//

import Foundation

protocol ItemManagerProtocol {
    func fetchItemsAndCategories(completion: @escaping (Result<(items: [ItemModel], categories: Categories), ConnectionError>) -> Void) async throws
    func fetchCategoryItems(category: String, completion: @escaping (Result<[ItemModel], ConnectionError>) -> Void) async throws
    func fetchItem(id: Int, completion: @escaping (Result<ItemModel, ConnectionError>) -> Void) async throws
}

final class ItemManager {
    
    private let connectionManager = ConnectionManager.shared
    private let dispatchGroup = DispatchGroup()
    private var items: [ItemModel] = []
    private var categories: Categories = []
}

extension ItemManager: ItemManagerProtocol {
    
    func fetchItemsAndCategories(completion: @escaping (Result<(items: [ItemModel], categories: Categories), ConnectionError>) -> Void) async throws {
        dispatchGroup.enter()
        do {
            let endPoint = ItemsAPICaller.allItems
            let decoded = try await connectionManager.request(endPoint, type: [ItemModel].self)
            items = decoded ?? []
            dispatchGroup.leave()
        } catch let error as ConnectionError {
            dispatchGroup.leave()
            completion(.failure(error))
            print("Couldn't fetch all items: \(error.localizedDescription)")
            throw error
        }
        dispatchGroup.enter()
        do {
            let endPoint = ItemsAPICaller.categories
            let decodedCategories = try await connectionManager.request(endPoint, type: Categories.self)
            categories = decodedCategories ?? []
            dispatchGroup.leave()
        } catch let error as ConnectionError {
            dispatchGroup.leave()
            print("Couldn't fetch categories: \(error.localizedDescription)")
            completion(.failure(error))
            throw error
        }
        dispatchGroup.notify(queue: .main) {
            completion(.success((self.items, self.categories)))
        }
    }
    
    func fetchCategoryItems(category: String, completion: @escaping (Result<[ItemModel], ConnectionError>) -> Void) async throws {
        do {
            let endPoint = ItemsAPICaller.category(category)
            let items = try await connectionManager.request(endPoint, type: [ItemModel].self)
            completion(.success(items ?? []))
        } catch let error as ConnectionError {
            print("Couldn't fetch category items: \(error.localizedDescription)")
            completion(.failure(error))
            throw error
        }
    }
    
    func fetchItem(id: Int, completion: @escaping (Result<ItemModel, ConnectionError>) -> Void) async throws {
        do {
            let endPoint = ItemsAPICaller.fetchItem(id)
            let item = try await connectionManager.request(endPoint, type: ItemModel.self)
            if let item {
                completion(.success(item))
            }
        }catch let error as ConnectionError {
                print("Couldn't fetch item: \(error.localizedDescription)")
            completion(.failure(error))
            throw error
            }
        }
    }

