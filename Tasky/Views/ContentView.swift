//
//  ContentView.swift
//  Tasky
//
//  Created by Mahdi BND on 6/1/23.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel = TaskManager()
	
	var body: some View {
		NavigationView {
			List {
				Section("Pending") {
					ForEach(viewModel.pendingTasks) { task in
						Button(action: {
							withAnimation {
								viewModel.markAsDone(task: task)
							}
						}) {
							Text(task.title)
								.foregroundColor(.primary)
						}
					}
						// reorder items from on point to another
					.onMove { source, destination in
						viewModel.move(from: source, to: destination, .pending)
					}
					
				}
				
				Section("Completed") {
					ForEach(viewModel.completedTasks) { task in
						Text(task.title)
							.foregroundColor(.secondary)
					}
						// reorder items from on point to another
					.onMove { source, destination in
						viewModel.move(from: source, to: destination, .completed)
					}
				}
			}
			.id(UUID())
			.toolbar {
				EditButton()
			}
			.navigationTitle("Tasks")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			.preferredColorScheme(.dark)
    }
}



/*
 ● The user should be able to add new tasks with a title and description.
 ● The user should be able to view all tasks in a list view.
 ● The user should be able to mark a task as completed.
 ● The user should be able to filter tasks by completion status (completed or not completed).
 */