class ListeningLesson {
	final String title;
	final String description;
	final String level;
	final String duration;
	final int audios;
	final double progress;
	final ListeningStatus status;
	final List<ListeningLessonContent> contents;

	const ListeningLesson({
		required this.title,
		required this.description,
		required this.level,
		required this.duration,
		required this.audios,
		required this.progress,
		required this.status,
		required this.contents,
	});

	int get totalContents => contents.length;

	int get completedContents =>
			contents.where((content) => content.completed).length;
}

class ListeningLessonContent {
	final int order;
	final String title;
	final String durationLabel;
	final int questions;
	final bool completed;
	final String audioUrl;

	const ListeningLessonContent({
		required this.order,
		required this.title,
		required this.durationLabel,
		required this.questions,
		required this.completed,
		required this.audioUrl,
	});
}

enum ListeningStatus { completed, inProgress }