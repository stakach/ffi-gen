module FFI::Gen::Clang
  # Contains the results of code-completion.
  #
  # This data structure contains the results of code completion, as
  # produced by \c clang_codeCompleteAt(). Its contents must be freed by
  # \c clang_disposeCodeCompleteResults.
  #
  # ## Fields:
  # :results ::
  #   (CompletionResult) The code-completion results.
  # :num_results ::
  #   (Integer) The number of code-completion results stored in the
  #   \c Results array.
  class CodeCompleteResults < FFI::Struct
    layout :results, CompletionResult,
           :num_results, :uint
  end

end
