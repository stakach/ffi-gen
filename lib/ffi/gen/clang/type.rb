module FFI::Gen::Clang
  # The type of an element in the abstract syntax tree.
  #
  # ## Fields:
  # :kind ::
  #   (Symbol from `enum_type_kind`)
  # :data ::
  #   (Array<FFI::Pointer(*Void)>)
  class Type < FFI::Struct
    layout :kind, :type_kind,
           :data, [:pointer, 2]
  end

end
