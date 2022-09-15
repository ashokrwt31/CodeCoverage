//
//  NewsViewModel.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 22/04/22.
//

import Foundation

typealias NewsCompletionClosure = ((News?, Error?) -> Void)

typealias NewsViewModelCompletionClosure = (([NewsVMSource]?, Error?) -> Void)

struct NewsViewModel {
    
    func callNetworkAPI(completion: NewsCompletionClosure?) {
        guard let url = API.baseURL else {
            print(API.baseURL)
            completion?(nil, ARNetworkError.invalidUrl)
            return
        }
        let networkManager = ARNewtworkManager(url)
        guard let request = networkManager?.createRequest(service: API.sourceService, params: nil) else {
                completion?(nil, ARNetworkError.invalidUrl)
                return
        }
        networkManager?.executeRequest(request: request, completion: completion)
    }
        
    func callAPI(completion: NewsViewModelCompletionClosure?) {
        callNetworkAPI { (news, error) in
            var newsVMSource = [NewsVMSource]()
            news?.sources.forEach { newsSource in
                newsVMSource.append(NewsVMSource(newsSource: newsSource))
            }
            completion?(news == nil ? nil : newsVMSource, error)
        }
    }
}

/*
    Busniess model when we are using MVVM architecture(add one more layer ViewModel)
*/
struct NewsVMSource {
    let description: String
    let url: String
    let category: String
    let countryCode: String
    let country: String
    
    init(newsSource: NewsSource) {
        self.description = newsSource.description
        self.category = newsSource.category.capitalized
        self.countryCode = newsSource.country
        self.url = newsSource.url
        let currentLocale: Locale = Locale.current
        self.country = currentLocale.localizedString(forRegionCode: countryCode) ?? ""
    }
}
