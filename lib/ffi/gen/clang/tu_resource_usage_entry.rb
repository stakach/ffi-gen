module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :kind ::
  #   (Symbol from `enum_tu_resource_usage_kind`) The memory usage category.
  # :amount ::
  #   (Integer) Amount of resources used.
  #         The units will depend on the resource kind.
  class TUResourceUsageEntry < FFI::Struct
    layout :kind, :tu_resource_usage_kind,
           :amount, :ulong
  end

end
