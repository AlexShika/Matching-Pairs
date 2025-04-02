//
//  ThemeService.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 01.04.2025.
//

import Foundation

class ThemeService {
    func fetchThemes(completion: @escaping ([ThemeRemoteModel]) -> Void) {
        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/concentrationgame-20753.appspot.com/o/themes.json?alt=media&token=6898245a-0586-4fed-b30e-5078faeba078") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let themes = try JSONDecoder().decode([ThemeRemoteModel].self, from: data)
                    DispatchQueue.main.async {
                        completion(themes)
                    }
                } catch {
                    print("Error decoding themes: \(error)")
                }
            } else {
                print("Error fetching themes: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}
