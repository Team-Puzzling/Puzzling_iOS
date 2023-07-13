//
//  MyProjectDataModel.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/12.
//

struct MyProjectDataModel {
    let projectName: String
    let startDate: String
    let projectId: Int
}

extension MyProjectDataModel {
    static func dummy() -> [MyProjectDataModel] {
        return [MyProjectDataModel(projectName: "Piickle", startDate: "2023-07-13", projectId: 2),
                MyProjectDataModel(projectName: "HARA", startDate: "2023-07-14", projectId: 8),
                MyProjectDataModel(projectName: "HARA", startDate: "2023-07-15", projectId: 8)]
    }
}
