/// The model that is used for generating the cards.
enum Model {
  /// The default model.
  gpt3_5,

  /// The model that is only available for plus users.
  gpt4;

  /// Returns if the model is only available for plus users.
  bool isPlus() {
    return switch (this) {
      Model.gpt3_5 => false,
      Model.gpt4 => true,
    };
  }

  String getUiText() {
    return switch (this) {
      Model.gpt3_5 => 'GPT-3.5',
      Model.gpt4 => 'GPT-4',
    };
  }
}
