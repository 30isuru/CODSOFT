class ToDo {
  String id;
  String title;
  int isdone;

  ToDo({required this.id, required this.title, this.isdone = 0});
  ToDo copyWith({
    String? id,
    String? title,
    int? isdone,
  }) {
    return ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      isdone: isdone ?? this.isdone,
    );
  }

  static List<ToDo> todoList() {
    return [
      ToDo(id: '1', title: 'getup', isdone: 0),
      ToDo(id: '2', title: 'washing', isdone: 1),
      ToDo(id: '3', title: 'driving', isdone: 1),
      ToDo(id: '4', title: 'singing', isdone: 1),
      ToDo(id: '5', title: 'reading', isdone: 1),
      ToDo(id: '6', title: 'sleep', isdone: 0),
    ];
  }
}
