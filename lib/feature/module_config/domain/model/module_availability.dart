class ModuleAvailability {
  final bool chatbot;
  final bool shadowverse;
  final bool academy;
  final bool competition;

  const ModuleAvailability({
    this.chatbot = false,
    this.shadowverse = false,
    this.academy = false,
    this.competition = false,
  });

  bool get isEmpty => !chatbot && !shadowverse && !academy && !competition;
}
