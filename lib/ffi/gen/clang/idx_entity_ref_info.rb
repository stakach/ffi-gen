module FFI::Gen::Clang
  # Data for IndexerCallbacks#indexEntityReference.
  #
  # ## Fields:
  # :kind ::
  #   (Symbol from `enum_idx_entity_ref_kind`)
  # :cursor ::
  #   (Cursor) Reference cursor.
  # :loc ::
  #   (IdxLoc)
  # :referenced_entity ::
  #   (IdxEntityInfo) The entity that gets referenced.
  # :parent_entity ::
  #   (IdxEntityInfo) Immediate "parent" of the reference. For example:
  #
  #   \code
  #   Foo *var;
  #   \endcode
  #
  #   The parent of reference of type 'Foo' is the variable 'var'.
  #   For references inside statement bodies of functions/methods,
  #   the parentEntity will be the function/method.
  # :container ::
  #   (IdxContainerInfo) Lexical container context of the reference.
  class IdxEntityRefInfo < FFI::Struct
    layout :kind, :idx_entity_ref_kind,
           :cursor, Cursor.by_value,
           :loc, IdxLoc.by_value,
           :referenced_entity, IdxEntityInfo.by_ref,
           :parent_entity, IdxEntityInfo.by_ref,
           :container, IdxContainerInfo.by_ref
  end

end
