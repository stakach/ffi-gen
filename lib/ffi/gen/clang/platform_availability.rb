module FFI::Gen::Clang
  # Describes the availability of a given entity on a particular platform, e.g.,
  # a particular class might only be available on Mac OS 10.7 or newer.
  #
  # ## Fields:
  # :platform ::
  #   (String) A string that describes the platform for which this structure
  #   provides availability information.
  #
  #   Possible values are "ios" or "macosx".
  # :introduced ::
  #   (Version) The version number in which this entity was introduced.
  # :deprecated ::
  #   (Version) The version number in which this entity was deprecated (but is
  #   still available).
  # :obsoleted ::
  #   (Version) The version number in which this entity was obsoleted, and therefore
  #   is no longer available.
  # :unavailable ::
  #   (Integer) Whether the entity is unconditionally unavailable on this platform.
  # :message ::
  #   (String) An optional message to provide to a user of this API, e.g., to
  #   suggest replacement APIs.
  class PlatformAvailability < FFI::Struct
    layout :platform, String.by_value,
           :introduced, Version.by_value,
           :deprecated, Version.by_value,
           :obsoleted, Version.by_value,
           :unavailable, :int,
           :message, String.by_value
  end

end
