//
//  TaskManager.swift
//  Tasky
//
//  Created by Mahdi BND on 6/1/23.
//

import Foundation
import SwiftUI

class TaskManager: ObservableObject {
	@Published var pendingTasks = [Task]()
	@Published var completedTasks = [Task]()
	@Published var newTaskManager = NewTask.manager
	
		// TODO: remove this, make it dynamic with injection
	init() {
			// populate with testTasks for testing
		pendingTasks = testTasks.filter { !$0.isFinished }
		completedTasks = testTasks.filter { $0.isFinished }
	}
	
	func markAsDone(task: Task) {
		guard let index = pendingTasks.firstIndex(of: task) else { return }
		pendingTasks[index].isFinished = true
		let task = pendingTasks.remove(at: index)
		completedTasks.append(task)
	}
	
	// List jobs methods - move, delete, etc...
	func move(from: IndexSet, to: Int, _ type: TaskType) {
		switch type {
			case .pending:
				move(from: from, to: to, list: &pendingTasks)
			case .completed:
				move(from: from, to: to, list: &completedTasks)
		}
	}
	
	private func move(from: IndexSet, to: Int, list: inout [Task]) {
		list.move(fromOffsets: from, toOffset: to)
	}
	
	func delete(at offsets: IndexSet) {
		pendingTasks.remove(atOffsets: offsets)
	}
	
	func addTask() {
		guard let task = newTaskManager.make() else { return }
		pendingTasks.append(task)
	}
	
	enum TaskType {
		case pending, completed
	}
}

class NewTask: ObservableObject {
	@Published var title: String = ""
	@Published var description: String = ""
	
	// one instance is enough, so we make it singleton
	static let manager = NewTask()
	
	private init() { }
	
	
	func make() -> Task? {
		if title.isEmpty { return nil }
		let task = Task(title: title, description: description)
		title = ""
		description = ""
		
		return task
	}
}
