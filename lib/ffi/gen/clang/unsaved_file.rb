module FFI::Gen::Clang
  # Provides the contents of a file that has not yet been saved to disk.
  #
  # Each CXUnsavedFile instance provides the name of a file on the
  # system along with the current contents of that file that have not
  # yet been saved to disk.
  #
  # ## Fields:
  # :filename ::
  #   (String) The file whose contents have not yet been saved.
  #
  #   This file must already exist in the file system.
  # :contents ::
  #   (String) A buffer containing the unsaved contents of this file.
  # :length ::
  #   (Integer) The length of the unsaved contents of this buffer.
  class UnsavedFile < FFI::Struct
    layout :filename, :string,
           :contents, :string,
           :length, :ulong
  end

end
