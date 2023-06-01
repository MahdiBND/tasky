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
					// Add item
					HStack(alignment: .top) {
						Image(systemName: "plus.circle.fill")
							.foregroundColor(.green)
							.onTapGesture(perform: viewModel.addTask)
						VStack {
							TextField("Title", text: $viewModel.newTaskManager.title)
							TextField("Description", text: $viewModel.newTaskManager.description)
						}
					}
					
					// list items
					ForEach(viewModel.pendingTasks, id: \.self) { task in
						Button(action: {
							viewModel.markAsDone(task: task)
						}) {
							VStack(alignment: .leading, spacing: 5) {
								Text(task.title)
									.foregroundColor(.primary)
								Text(task.description)
									.foregroundColor(.secondary)
							}
						}
					}
						// reorder items from on point to another
					.onMove { source, destination in
						viewModel.move(from: source, to: destination, .pending)
					}
					.onDelete { indexSet in
						viewModel.delete(at: indexSet)
					}
					
				}
				
				Section("Completed") {
					ForEach(viewModel.completedTasks, id: \.self) { task in
						VStack(alignment: .leading, spacing: 5) {
							Text(task.title)
								.foregroundColor(.secondary)
							Text(task.description)
								.foregroundColor(.secondary)
								.fontWeight(.light)
						}
					}
						// reorder items from on point to another
					.onMove { source, destination in
						viewModel.move(from: source, to: destination, .completed)
					}
				}
			}
			.toolbar {
				EditButton()
			}
			.onTapGesture(perform: hideKeyboard)
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



extension View {
		/// Resigns first responder when called.
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
