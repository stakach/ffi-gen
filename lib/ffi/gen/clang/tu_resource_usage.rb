module FFI::Gen::Clang
  # The memory usage of a CXTranslationUnit, broken into categories.
  #
  # ## Fields:
  # :data ::
  #   (FFI::Pointer(*Void)) Private data member, used for queries.
  # :num_entries ::
  #   (Integer) The number of entries in the 'entries' array.
  # :entries ::
  #   (TUResourceUsageEntry) An array of key-value pairs, representing the breakdown of memory
  #               usage.
  class TUResourceUsage < FFI::Struct
    layout :data, :pointer,
           :num_entries, :uint,
           :entries, TUResourceUsageEntry.by_ref
  end

end
