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
        
        itens = [ .init(id: 0, nodeID: "", name: "Teste", owner: .init(login: "login", id: 0, nodeID: "", avatarURL: URL(string:                             "https://avatars.githubusercontent.com/u/8781288?v=4")), description: "descricao do repositorio", pullsURL: "", stargazersCount: 500, forksCount: 100),
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
    
}
