class Todo {
  final String id;
  final String description;
  final int millis;
  final bool completed;

  const Todo(
      {required this.id,
      required this.description,
      required this.millis,
      required this.completed});
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      description: json['description'] as String,
      millis: json['millis'] as int,
        completed: json['completed'] as bool
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'millis': millis,
      'completed': completed
    };
  }

  static List<Todo> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => Todo.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
