//
//  TaskManager.swift
//  Tasky
//
//  Created by Mahdi BND on 6/1/23.
//

import Foundation

class TaskManager: ObservableObject {
	@Published var pendingTasks = [Task]()
	@Published var completedTasks = [Task]()
	
		// TODO: remove this, make it dynamic with injection
	init() {
			// populate with testTasks for testing
		pendingTasks = testTasks.filter { !$0.isFinished }
		completedTasks = testTasks.filter { $0.isFinished }
	}
	
	func markAsDone(task: Task) {
		pendingTasks.removeAll { $0.id == task.id }
		completedTasks.append(task)
	}
	
	
	func move(from: IndexSet, to: Int, _ type: TaskType) {
		switch type {
			case .pending:
				move(from: from, to: to, list: &pendingTasks)
			case .completed:
				move(from: from, to: to, list: &completedTasks)
		}
	}
	
	private func move(from: IndexSet, to: Int, list: inout [Task] ) {
		list.move(fromOffsets: from, toOffset: to)
	}
	
	enum TaskType {
		case pending, completed
	}
}
