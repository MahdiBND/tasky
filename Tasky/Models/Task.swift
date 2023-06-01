//
//  Task.swift
//  Tasky
//
//  Created by Mahdi BND on 6/1/23.
//

import Foundation

	// data source
struct Task: Identifiable, Codable, Hashable {
	var id: UUID { UUID() }
	var title: String
	var description: String
	var isFinished: Bool = false
}

let testTasks = [
	// pending tasks
	Task(title: "DM John", description: "Tell him about the job"),
	Task(title: "buy food", description: "burger"),
	Task(title: "WWDC", description: "Watch the event"),
	
	// finished tasks
	Task(title: "go to bank", description: "new account", isFinished: true),
	Task(title: "Send Resume", description: "to webmetric", isFinished: true),
	Task(title: "finish challenge", description: "iOS Code challenge", isFinished: true),
]
