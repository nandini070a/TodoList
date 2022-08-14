

struct ToDoItem {
    var title: String
    var done: Bool
    
    init(_ title: String) {
        self.title = title
        self.done = false
    }
    
    init?(_ plist: [String: Any]?) {
        guard let propertyList = plist,
              let title = propertyList["title"] as? String,
              let done = propertyList["done"] as? Bool
        else {return nil}
        
        self.title = title
        self.done = done
    }
    
    func toPropertylist() -> [String: Any] {
        return ["title": self.title, "done": self.done]
    }
}
