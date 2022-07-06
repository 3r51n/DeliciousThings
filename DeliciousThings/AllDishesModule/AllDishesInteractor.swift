//
//  CategoriesToDishesInteractor.swift
//  DeliciousThings
//
//  Created by MacBook on 23.06.2022.
//

import Foundation
import ProgressHUD

struct ApiResponse1<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}

enum AppError1: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Bruhhh!!! I have no idea what go on"
        case .invalidUrl:
            return "HEYYY!!! Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}

enum Method1: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum Route1 {
    static let baseUrl = "https://yummie.glitch.me"
    
    case fetchAllCategories
    case placeOrder(String)
    case fetchCategoryDishes(String)
    case fetchOrders
    
    var description: String {
        switch self {
        case .fetchAllCategories:
            return "/dish-categories"
        case .placeOrder(let dishId):
            return "/orders/\(dishId)"
        case .fetchCategoryDishes(let categoryId):
            return "/dishes/\(categoryId)"
        case .fetchOrders:
            return "/orders"
        }
    }
}


class AllDishesInteractor {
    
    var presenter:PAllDishesInteractorToPresenter?
    let catId:[String] = ["cat1","cat2", "cat3", "cat4", "cat5"]
}

extension AllDishesInteractor:PAllDishesInteractor {
    
    func getAllDishes() {
        ProgressHUD.show()
        
        for catId in catId {
            NetworkService1.shared.fetchCategoryDishes(categoryId: catId) { result in
                switch result {
                case .success(let foods):
                    self.presenter?.getAllDishes(data: foods)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        ProgressHUD.dismiss()
   }
}

struct NetworkService1 {
    
    static let shared = NetworkService1()
    
    private init() {}
    
    func fetchAllCategories(completion: @escaping(Result<AllDishes, Error>) -> Void) {
        request(route1: .fetchAllCategories, method1: .get, completion: completion)
    }
    
    func placeOrder(dishId: String, name: String, completion: @escaping(Result<Order, Error>) -> Void) {
        let params = ["name": name]
        
        request(route1: .placeOrder(dishId), method1: .post, parameters: params, completion: completion)
    }
    
    func fetchCategoryDishes(categoryId: String, completion: @escaping(Result<[Foods], Error>) -> Void) {
        request(route1: .fetchCategoryDishes(categoryId), method1: .get, completion: completion)
    }
    
    func fetchOrders(completion: @escaping(Result<[Order], Error>) -> Void) {
        request(route1: .fetchOrders, method1: .get, completion: completion)
    }
    
    private func request<T: Decodable>(route1: Route,
                                     method1: Method,
                                     parameters: [String: Any]? = nil,
                                     completion: @escaping(Result<T, Error>) -> Void) {
        guard let request = createRequest(route: route1, method: method1, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                //let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
                //print("The response is:\n\(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?,
                                              completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
    
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }
            
            if let decodedData = response.data {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.unknownError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
