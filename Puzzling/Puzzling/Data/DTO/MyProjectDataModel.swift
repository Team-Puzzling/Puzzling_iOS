//
//  MyProjectDataModel.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

struct MyProjectDataModel {
    let projectName: String
    let startDate: String
    let projectId: Int
}

extension MyProjectDataModel {
    static func dummy() -> [MyProjectDataModel] {
        return [MyProjectDataModel(projectName: "진짜진짜긴이름이면어떡하지요그러게요", startDate: "2023-07-13", projectId: 1),
                MyProjectDataModel(projectName: "Project1", startDate: "2023-07-14", projectId: 2),
                MyProjectDataModel(projectName: "Project2", startDate: "2023-07-15", projectId: 3),
                MyProjectDataModel(projectName: "Project3", startDate: "2023-07-16", projectId: 4),
                MyProjectDataModel(projectName: "Project4", startDate: "2023-07-17", projectId: 5),
                MyProjectDataModel(projectName: "Project5", startDate: "2023-07-18", projectId: 6),
                MyProjectDataModel(projectName: "Project6", startDate: "2023-07-19", projectId: 7),
                MyProjectDataModel(projectName: "Project7", startDate: "2023-07-20", projectId: 8),
                MyProjectDataModel(projectName: "Project8", startDate: "2023-07-21", projectId: 9)]
    }
}
