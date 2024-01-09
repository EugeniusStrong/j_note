class NoteModel {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final int image;
  final bool isDone;

  NoteModel(
    this.id,
    this.title,
    this.subtitle,
    this.time,
    this.image,
    this.isDone,
  );

  NoteModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? time,
    int? image,
    bool? isDone,
  }) {
    return NoteModel(
      id ?? this.id,
      title ?? this.title,
      subtitle ?? this.subtitle,
      time ?? this.time,
      image ?? this.image,
      isDone ?? this.isDone,
    );
  }
}
