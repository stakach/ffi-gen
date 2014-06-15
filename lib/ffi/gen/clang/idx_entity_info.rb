module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :kind ::
  #   (Symbol from `enum_idx_entity_kind`)
  # :template_kind ::
  #   (Symbol from `enum_idx_entity_cxx_template_kind`)
  # :lang ::
  #   (Symbol from `enum_idx_entity_language`)
  # :name ::
  #   (String)
  # :usr ::
  #   (String)
  # :cursor ::
  #   (Cursor)
  # :attributes ::
  #   (FFI::Pointer(**IdxAttrInfo))
  # :num_attributes ::
  #   (Integer)
  class IdxEntityInfo < FFI::Struct
    layout :kind, :idx_entity_kind,
           :template_kind, :idx_entity_cxx_template_kind,
           :lang, :idx_entity_language,
           :name, :string,
           :usr, :string,
           :cursor, Cursor.by_value,
           :attributes, :pointer,
           :num_attributes, :uint
  end

end
