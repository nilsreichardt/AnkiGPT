// ignore_for_file: deprecated_member_use_from_same_package

/// The model that is used for generating the cards.
enum Model {
  /// The default model.
  ///
  /// Keeping the model in the source code for backwards compatibility (showing
  /// the model in old sessions).
  @Deprecated('Use gpt4o_mini instead')
  gpt3_5,

  /// The model that is only available for plus users.
  ///
  /// Keeping the model in the source code for backwards compatibility (showing
  /// the model in old sessions).
  @Deprecated('Use gpt4o instead')
  gpt4,

  /// The default model.
  // ignore: constant_identifier_names
  gpt4o_mini,

  /// The model that is only available for plus users.
  gpt4o;

  /// Returns the name of the model.
  ///
  /// Uses the model naming convention of our backend.
  String get snakeCaseName {
    return switch (this) {
      Model.gpt4o_mini => 'gpt-4o-mini',
      Model.gpt4o => 'gpt-4o',
      Model.gpt3_5 => 'gpt-3.5',
      Model.gpt4 => 'gpt-4',
    };
  }

  /// Returns if the model is only available for plus users.
  bool isPlus() {
    return switch (this) {
      Model.gpt3_5 => false,
      Model.gpt4 => true,
      Model.gpt4o_mini => false,
      Model.gpt4o => true,
    };
  }

  String getUiText() {
    return switch (this) {
      Model.gpt3_5 => 'GPT-3.5',
      Model.gpt4 => 'GPT-4',
      Model.gpt4o_mini => 'GPT-4o mini',
      Model.gpt4o => 'GPT-4o',
    };
  }
}
