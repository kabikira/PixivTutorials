//
//  IllustViewModel.swift
//  PixivTutorials1
//
//  Created by koala panda on 2024/05/31.
//

import Combine
import IllustAPIMock

final class IllustViewModel {
    @Published var rankingIllsts: [Illust] = []
    @Published var recommendedIllusts: [Illust] = []

    private let api: IllustAPIMock

    init(api: IllustAPIMock) {
        self.api = api
    }

    func fetchIllusts() async {
        do {
            rankingIllsts = try await api.getRanking()
            recommendedIllusts = try await api.getRecommended()
        } catch {
            print(error)
        }
    }
}
