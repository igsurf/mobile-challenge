//
//  Mock.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 27/04/21.
//

import Foundation

class Mock {
    
    func createMockRep() -> JavaPopViewModel {

        var itens = [Items]()
        
        itens = [ .init(id: 0, nodeID: "", name: "Teste", owner: .init(login: "Renato", id: 0, nodeID: "", avatarURL: URL(string:                             "https://avatars.githubusercontent.com/u/8781288?v=4")), description: "descricao do repositorio muito grande muito grande muito grande muito grande muito grande muito grande muito grande muito grande muito grande muito grande", pullsURL: "", stargazersCount: 500, forksCount: 100),
                  .init(id: 0, nodeID: "", name: "Teste1", owner: .init(login: "login", id: 0, nodeID: "", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/8781288?v=4")), description: "descricao do repositorio", pullsURL: "", stargazersCount: 500, forksCount: 100),
                  .init(id: 0, nodeID: "", name: "Teste2", owner: .init(login: "login", id: 0, nodeID: "", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/8781288?v=4")), description: "descricao do repositorio", pullsURL: "", stargazersCount: 500, forksCount: 100),
                  .init(id: 0, nodeID: "", name: "Teste3", owner: .init(login: "login", id: 0, nodeID: "", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/8781288?v=4")), description: "descricao do repositorio", pullsURL: "", stargazersCount: 500, forksCount: 100),
                  .init(id: 0, nodeID: "", name: "Teste4", owner: .init(login: "login", id: 0, nodeID: "", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/8781288?v=4")), description: "descricao do repositorio", pullsURL: "", stargazersCount: 500, forksCount: 100),
                  .init(id: 0, nodeID: "", name: "Teste5", owner: .init(login: "login", id: 0, nodeID: "", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/8781288?v=4")), description: "descricao do repositorio", pullsURL: "", stargazersCount: 500, forksCount: 100),
                  .init(id: 0, nodeID: "", name: "Teste6", owner: .init(login: "login", id: 0, nodeID: "", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/8781288?v=4")), description: "descricao do repositorio", pullsURL: "", stargazersCount: 500, forksCount: 100),
                  .init(id: 0, nodeID: "", name: "Teste7", owner: .init(login: "login", id: 0, nodeID: "", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/8781288?v=4")), description: "descricao do repositorio", pullsURL: "", stargazersCount: 500, forksCount: 100),
                  .init(id: 0, nodeID: "", name: "Teste8", owner: .init(login: "login", id: 0, nodeID: "", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/8781288?v=4")), description: "descricao do repositorio", pullsURL: "", stargazersCount: 500, forksCount: 100),
                  .init(id: 0, nodeID: "", name: "Teste9", owner: .init(login: "login", id: 0, nodeID: "", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/8781288?v=4")), description: "descricao do repositorio", pullsURL: "", stargazersCount: 500, forksCount: 100),
        ]
        
        let javapop = JavaPopViewModel(items: itens)
        return javapop
    }
    
    func createMockPullReques() -> PullRequestViewModel {

        var itens = [PullRequest]()
        
        itens = [ .init(url: URL(string: "https://api.github.com/repos/spring-projects/spring-boot/pulls/26258")!, id: 624371273, nodeID: "MDExOlB1bGxSZXF1ZXN0NjI0MzcxMjcz", htmlURL: URL(string: "https://github.com/spring-projects/spring-boot/pull/26258")!, number: 26258, state: "open", locked: false, title: "Add properties for Dynatrace metrics API v2 ingest with Micrometer", body: "This PR contains new additions to the properties that allow Micrometer to export to two different Dynatrace APIs. The code in the two Micrometer PRs (see below) depends on this, and will hopefully be included in the 1.8.0 release of Micrometer.\r\n\r\nResolves #24978\r\n\r\n- Micrometer issue: https://github.com/micrometer-metrics/micrometer/issues/2295\r\n- Move Dynatrace exporter v1: https://github.com/micrometer-metrics/micrometer/pull/2553\r\n- Add Dynatrace exporter v2: https://github.com/micrometer-metrics/micrometer/pull/2581"),
                .init(url: URL(string: "https://api.github.com/repos/spring-projects/spring-boot/pulls/26258")!, id: 624371273, nodeID: "MDExOlB1bGxSZXF1ZXN0NjI0MzcxMjcz", htmlURL: URL(string: "https://github.com/spring-projects/spring-boot/pull/26258")!, number: 26258, state: "open", locked: false, title: "Add properties for Dynatrace metrics API v2 ingest with Micrometer", body: "This PR contains new additions to the properties that allow Micrometer to export to two different Dynatrace APIs. The code in the two Micrometer PRs (see below) depends on this, and will hopefully be included in the 1.8.0 release of Micrometer.\r\n\r\nResolves #24978\r\n\r\n- Micrometer issue: https://github.com/micrometer-metrics/micrometer/issues/2295\r\n- Move Dynatrace exporter v1: https://github.com/micrometer-metrics/micrometer/pull/2553\r\n- Add Dynatrace exporter v2: https://github.com/micrometer-metrics/micrometer/pull/2581"),
                .init(url: URL(string: "https://api.github.com/repos/spring-projects/spring-boot/pulls/26258")!, id: 624371273, nodeID: "MDExOlB1bGxSZXF1ZXN0NjI0MzcxMjcz", htmlURL: URL(string: "https://github.com/spring-projects/spring-boot/pull/26258")!, number: 26258, state: "open", locked: false, title: "Add properties for Dynatrace metrics API v2 ingest with Micrometer", body: "This PR contains new additions to the properties that allow Micrometer to export to two different Dynatrace APIs. The code in the two Micrometer PRs (see below) depends on this, and will hopefully be included in the 1.8.0 release of Micrometer.\r\n\r\nResolves #24978\r\n\r\n- Micrometer issue: https://github.com/micrometer-metrics/micrometer/issues/2295\r\n- Move Dynatrace exporter v1: https://github.com/micrometer-metrics/micrometer/pull/2553\r\n- Add Dynatrace exporter v2: https://github.com/micrometer-metrics/micrometer/pull/2581"),
                .init(url: URL(string: "https://api.github.com/repos/spring-projects/spring-boot/pulls/26258")!, id: 624371273, nodeID: "MDExOlB1bGxSZXF1ZXN0NjI0MzcxMjcz", htmlURL: URL(string: "https://github.com/spring-projects/spring-boot/pull/26258")!, number: 26258, state: "open", locked: false, title: "Add properties for Dynatrace metrics API v2 ingest with Micrometer", body: "This PR contains new additions to the properties that allow Micrometer to export to two different Dynatrace APIs. The code in the two Micrometer PRs (see below) depends on this, and will hopefully be included in the 1.8.0 release of Micrometer.\r\n\r\nResolves #24978\r\n\r\n- Micrometer issue: https://github.com/micrometer-metrics/micrometer/issues/2295\r\n- Move Dynatrace exporter v1: https://github.com/micrometer-metrics/micrometer/pull/2553\r\n- Add Dynatrace exporter v2: https://github.com/micrometer-metrics/micrometer/pull/2581"),
                .init(url: URL(string: "https://api.github.com/repos/spring-projects/spring-boot/pulls/26258")!, id: 624371273, nodeID: "MDExOlB1bGxSZXF1ZXN0NjI0MzcxMjcz", htmlURL: URL(string: "https://github.com/spring-projects/spring-boot/pull/26258")!, number: 26258, state: "open", locked: false, title: "Add properties for Dynatrace metrics API v2 ingest with Micrometer", body: "This PR contains new additions to the properties that allow Micrometer to export to two different Dynatrace APIs. The code in the two Micrometer PRs (see below) depends on this, and will hopefully be included in the 1.8.0 release of Micrometer.\r\n\r\nResolves #24978\r\n\r\n- Micrometer issue: https://github.com/micrometer-metrics/micrometer/issues/2295\r\n- Move Dynatrace exporter v1: https://github.com/micrometer-metrics/micrometer/pull/2553\r\n- Add Dynatrace exporter v2: https://github.com/micrometer-metrics/micrometer/pull/2581"),
                .init(url: URL(string: "https://api.github.com/repos/spring-projects/spring-boot/pulls/26258")!, id: 624371273, nodeID: "MDExOlB1bGxSZXF1ZXN0NjI0MzcxMjcz", htmlURL: URL(string: "https://github.com/spring-projects/spring-boot/pull/26258")!, number: 26258, state: "open", locked: false, title: "Add properties for Dynatrace metrics API v2 ingest with Micrometer", body: "This PR contains new additions to the properties that allow Micrometer to export to two different Dynatrace APIs. The code in the two Micrometer PRs (see below) depends on this, and will hopefully be included in the 1.8.0 release of Micrometer.\r\n\r\nResolves #24978\r\n\r\n- Micrometer issue: https://github.com/micrometer-metrics/micrometer/issues/2295\r\n- Move Dynatrace exporter v1: https://github.com/micrometer-metrics/micrometer/pull/2553\r\n- Add Dynatrace exporter v2: https://github.com/micrometer-metrics/micrometer/pull/2581")
        ]
        
        let pullRequest = PullRequestViewModel(pullrequest: itens)
        return pullRequest
    }
    
}
