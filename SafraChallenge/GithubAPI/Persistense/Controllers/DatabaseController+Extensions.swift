//
//  DatabaseController+Extensions.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 15/03/21.
//

import Foundation
import CoreData

extension DatabaseController {
    
    func set(repositories: [RepositoryView]) {
        repositories.forEach({ repository in
            set(repository: repository)
        })
    }
    
    func set(repository: RepositoryView) {
        if !checkRepositoryRecordExists(entity: "Repository", uniqueIdentity: String(describing: repository.id), idAttributeName: "id"), var repo = NSEntityDescription.insertNewObject(forEntityName: "Repository", into:  DatabaseController.instance.persistentContainer.viewContext) as? RepositoryEntity {
            
            repo = PersistenseMapper.instance.parse(from: repository, to: repo)
            
            DatabaseController.instance.saveContext()
        }
    }
    
    func updateRepository(repository: RepositoryView, pullRequests: [PullRequestView]) {
        if checkRepositoryRecordExists(entity: "Repository", uniqueIdentity: String(describing: repository.id), idAttributeName: "id") {
            
            var results: [NSManagedObject]? = []

            do {
                let context = getContext()
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Repository")
                fetchRequest.predicate = NSPredicate(format: "id = %@", String(describing: repository.id))
                
                results = try context.fetch(fetchRequest) as? [RepositoryEntity]
                if let results = results as? [RepositoryEntity], results.count > 0 {
                    results.forEach({ repository in
                        var prs: [PullRequestEntity] = []
                        pullRequests.forEach({ pullRequest in
                            if let pr = set(pullRequest: pullRequest, repository: repository) {
                                prs.append(pr)
                                repository.addToPullRequests(pr)
                            }
                        })
                        
                    })
                }
            }
            catch {
                RGLog.e("error executing fetch request: \(error)")
            }
            
            DatabaseController.instance.saveContext()
        }

    }
    
    func set(pullRequest: PullRequestView, repository: RepositoryEntity) -> PullRequestEntity? {
        if !checkRepositoryRecordExists(entity: "PullRequest", uniqueIdentity: String(describing: pullRequest.id), idAttributeName: "id"), var pr = NSEntityDescription.insertNewObject(forEntityName: "PullRequest", into:  DatabaseController.instance.persistentContainer.viewContext) as? PullRequestEntity {
            
            pr = PersistenseMapper.instance.parse(from: pullRequest, to: pr, repository: repository)
            
            return pr
            
        }
        
        return nil
    }
    
    func getRepositories() -> [RepositoryView] {
        var repositories: [RepositoryView] = []
        do {
            if let repos = try DatabaseController.instance.persistentContainer.viewContext.fetch(RepositoryEntity.fetchRequest()) as? [RepositoryEntity] {
                repos.forEach({ repo in
                    let rp = PersistenseMapper.instance.parse(from: repo)
                    repositories.append(rp)
                })
            }
        } catch {
            RGLog.e("Erro no banco, não conseguiu realizar a busca")
        }
        
        return repositories
    }
    
    func checkRepositoryRecordExists(entity: String, uniqueIdentity: String, idAttributeName:String) -> Bool {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
//        fetchRequest.predicate = NSPredicate(format: "\(idAttributeName) CONTAINS[cd] %@", uniqueIdentity)
        fetchRequest.predicate = NSPredicate(format: "\(idAttributeName) = %@", uniqueIdentity)

        var results: [NSManagedObject] = []

        do {
            results = try context.fetch(fetchRequest)
            try context.save()
        }
        catch {
            RGLog.e("error executing fetch request: \(error)")
        }

        return results.count > 0

    }
}
