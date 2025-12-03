class AddTodoModalStateData {
  final bool isDescription;
  final bool isFavorite;
  final String titleText;

  AddTodoModalStateData({
    required this.isDescription,
    required this.isFavorite,
    required this.titleText,
  });

  AddTodoModalStateData copyWith({
    bool? isDescription,
    bool? isFavorite,
    String? titleText,
  }) {
    return AddTodoModalStateData(
      isDescription: isDescription ?? this.isDescription,
      isFavorite: isFavorite ?? this.isFavorite,
      titleText: titleText ?? this.titleText,
    );
  }
}
