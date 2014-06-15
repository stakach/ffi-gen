module FFI::Gen::Clang
  # Data for ppIncludedFile callback.
  #
  # ## Fields:
  # :hash_loc ::
  #   (IdxLoc) Location of '#' in the \#include/\#import directive.
  # :filename ::
  #   (String) Filename as written in the \#include/\#import directive.
  # :file ::
  #   (FFI::Pointer(File)) The actual file that the \#include/\#import directive resolved to.
  # :is_import ::
  #   (Integer)
  # :is_angled ::
  #   (Integer)
  # :is_module_import ::
  #   (Integer) Non-zero if the directive was automatically turned into a module
  #   import.
  class IdxIncludedFileInfo < FFI::Struct
    layout :hash_loc, IdxLoc.by_value,
           :filename, :string,
           :file, :pointer,
           :is_import, :int,
           :is_angled, :int,
           :is_module_import, :int
  end

end
