//
//  ContentView.swift
//  AmplifyiOS
//
//  Created by Andrea Monroy on 3/22/23.
//
import Amplify
import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .task {
                    await performOnAppear()
                }
        }
        .padding()
    }
}

//saving to DataStore

//func performOnAppear() async {
//    do {
//        let item = Todo(name: "Finish quarter taxxes",
//                        priority: .high,
//                        description: "Taxes are due for the quarter next weeky")
//        let savedItem = try await Amplify.DataStore.save(item)
//        print("Saved item: \(savedItem.name)")
//    } catch {
//        print("Could not save item to DataStore: \(error)")
//    }
//}

//queary per key such as priority without where it queries all

//func performOnAppear() async {
//    do {
//        //let todos = try await Amplify.DataStore.query(Todo.self)
//        let todos = try await Amplify.DataStore.query(Todo.self,
//                                                      where: Todo.keys.priority.eq(Priority.high))
//        for todo in todos {
//            print("==== Todo ====")
//            print("Name: \(todo.name)")
//            if let description = todo.description {
//                print("Description: \(description)")
//            }
//            if let priority = todo.priority {
//                print("Priority: \(priority)")
//            }
//        }
//    } catch {
//        print("Could not query DataStore: \(error)")
//    }
//}

//func performOnAppear() async {
//    do {
//        let todos = try await Amplify.DataStore.query(Todo.self,
//                                                      where: Todo.keys.name.eq("Finish quarter taxxes"))
//        guard todos.count == 1, var updatedTodo = todos.first else {
//            print("Did not find exactly one todo, bailing")
//            return
//        }
//        updatedTodo.name = "File quarterly taxes"
//        let savedTodo = try await Amplify.DataStore.save(updatedTodo)
//        print("Updated item: \(savedTodo.name)")
//    } catch {
//        print("Unable to perform operation: \(error)")
//    }
//}

//func performOnAppear() async {
//    do {
//        let todos = try await Amplify.DataStore.query(Todo.self,
//                                                      where: Todo.keys.name.eq("File quarterly taxes"))
//        guard todos.count == 1, let toDeleteTodo = todos.first else {
//            print("Did not find exactly one todo, bailing")
//            return
//        }
//        try await Amplify.DataStore.delete(toDeleteTodo)
//        print("Deleted item: \(toDeleteTodo.name)")
//    } catch {
//        print("Unable to perform operation: \(error)")
//    }
//}


func performOnAppear() async {
    await subscribeTodos()
}


func subscribeTodos() async {
  do {
      let mutationEvents = Amplify.DataStore.observe(Todo.self)
      for try await mutationEvent in mutationEvents {
          print("Subscription got this value: \(mutationEvent)")
          do {
              let todo = try mutationEvent.decodeModel(as: Todo.self)
              
              switch mutationEvent.mutationType {
              case "create":
                  print("Created: \(todo)")
              case "update":
                  print("Updated: \(todo)")
              case "delete":
                  print("Deleted: \(todo)")
              default:
                  break
              }
          } catch {
              print("Model could not be decoded: \(error)")
          }
      }
  } catch {
      print("Unable to observe mutation events")
  }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
