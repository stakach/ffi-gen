module FFI::Gen::Clang
  # Uniquely identifies a CXFile, that refers to the same underlying file,
  # across an indexing session.
  #
  # ## Fields:
  # :data ::
  #   (Array<Integer>)
  class FileUniqueID < FFI::Struct
    layout :data, [:ulong_long, 3]
  end

end
