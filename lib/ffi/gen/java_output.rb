class FFI::Gen
  def generate_java
    writer = Writer.new "    ", " * ", "/**", " */"
    writer.puts "// Generated by ffi-gen. Please do not change this file by hand.", "import java.util.*;", "import com.sun.jna.*;", "import java.lang.annotation.*;", "import java.lang.reflect.Method;", "", "public interface #{@module_name} extends Library {"
    writer.indent do
      writer.puts "", *IO.readlines(File.join(File.dirname(__FILE__), "java_pre.java")).map(&:rstrip)
      writer.puts "", "public static #{@module_name} INSTANCE = JnaInstanceCreator.createInstance();", ""
      writer.puts "static class JnaInstanceCreator {"
      writer.indent do
        writer.puts "private static #{@module_name} createInstance() {"
        writer.indent do
          writer.puts "DefaultTypeMapper typeMapper = new DefaultTypeMapper();", "typeMapper.addFromNativeConverter(NativeEnum.class, new EnumConverter());", "typeMapper.addToNativeConverter(NativeEnum.class, new EnumConverter());", ""
          writer.puts "Map<String, Object> options = new HashMap<String, Object>();", "options.put(Library.OPTION_FUNCTION_MAPPER, new NativeNameAnnotationFunctionMapper());", "options.put(Library.OPTION_TYPE_MAPPER, typeMapper);", ""
          writer.puts "return (#{@module_name}) Native.loadLibrary(\"#{@ffi_lib}\", #{@module_name}.class, options);"
        end
        writer.puts "}"
      end
      writer.puts "}", ""
      declarations.each do |declaration|
        declaration.write_java writer
      end
    end
    writer.puts "}"
    writer.output
  end

  class Name
    JAVA_KEYWORDS = %w{abstract assert boolean break byte case catch char class const continue default do double else enum extends final finally float for goto if implements import instanceof int interface long native new package private protected public return short static strictfp super switch synchronized this throw throws transient try void volatile while}

    def to_java_downcase
      format :camelcase, :initial_downcase, JAVA_KEYWORDS
    end

    def to_java_classname
      format :camelcase, JAVA_KEYWORDS
    end

    def to_java_constant
      format :upcase, :underscores, JAVA_KEYWORDS
    end
  end

  class Type
    def java_description
      java_name
    end
  end

  class Enum
    def write_java(writer)
      return if @name.nil?
      shorten_names

      writer.comment do
        writer.write_description @description
        writer.puts "", "<em>This entry is only for documentation and no real method. The FFI::Enum can be accessed via #enum_type(:#{java_name}).</em>"
        writer.puts "", "=== Options:"
        @constants.each do |constant|
          writer.puts "#{constant[:name].to_java_constant} ::"
          writer.write_description constant[:comment], false, "  ", "  "
        end
        writer.puts "", "@method _enum_#{java_name}_", "@return [Symbol]", "@scope class"
      end

      writer.puts "public enum #{java_name} implements NativeEnum {"
      writer.indent do
        writer.write_array @constants, "," do |constant|
          "#{constant[:name].to_java_constant}(#{constant[:value]})"
        end
        writer.puts ";"

        writer.puts "", "private int nativeInt;", "", "private #{java_name}(int nativeInt) {", "    this.nativeInt = nativeInt;", "}", "", "@Override", "public int toNativeInt() {", "    return nativeInt;", "}"
      end
      writer.puts "}", ""
    end

    def java_name
      @java_name ||= @name.to_java_classname
    end

    def java_jna_type
      java_name
    end

    def java_description
      "Symbol from _enum_#{java_name}_"
    end
  end

  class StructOrUnion
    def write_java(writer)
      writer.comment do
        writer.write_description @description
        unless @fields.empty?
          writer.puts "", "= Fields:"
          @fields.each do |field|
            writer.puts ":#{field[:name].to_java_downcase} ::"
            writer.write_description field[:comment], false, "  (#{field[:type].java_description}) ", "  "
          end
        end
      end

      writer.puts "public static class #{java_name} extends #{@is_union ? 'Union' : (@fields.empty? ? 'PointerType' : 'Structure')} {"
      writer.indent do
        @fields.each do |field|
          writer.puts "public #{field[:type].java_jna_type} #{field[:symbol]};"
        end
        writer.puts "// hidden structure" if @fields.empty?
      end
      writer.puts "}", ""

      @written = true
    end

    def java_name
      @java_name ||= @name.to_java_classname
    end

    def java_jna_type
      @written ? java_name : "Pointer"
    end

    def java_description
      @written ? java_name : "FFI::Pointer(*#{java_name})"
    end
  end

  class FunctionOrCallback
    def write_java(writer)
      return if @is_callback # not yet supported

      writer.comment do
        writer.write_description @function_description
        writer.puts "", "<em>This entry is only for documentation and no real method.</em>" if @is_callback
        writer.puts "", "@method #{@is_callback ? "_callback_#{java_name}_" : java_name}(#{@parameters.map{ |parameter| parameter[:name].to_java_downcase }.join(', ')})"
        @parameters.each do |parameter|
          writer.write_description parameter[:description], false, "@param [#{parameter[:type].java_description}] #{parameter[:name].to_java_downcase} ", "  "
        end
        writer.write_description @return_value_description, false, "@return [#{@return_type.java_description}] ", "  "
        writer.puts "@scope class"
      end

      jna_signature = "#{@parameters.map{ |parameter| "#{parameter[:type].java_jna_type} #{parameter[:name].to_java_downcase}" }.join(', ')}"
      if @is_callback
        writer.puts "callback :#{java_name}, #{jna_signature}", ""
      else
        writer.puts "@NativeName(\"#{@name.raw}\")", "#{@return_type.java_jna_type} #{java_name}(#{jna_signature});", ""
      end
    end

    def java_name
      @java_name ||= @name.to_java_downcase
    end

    def java_jna_type
      java_name
    end

    def java_description
      "Proc(_callback_#{java_name}_)"
    end
  end

  class Define
    def write_java(writer)
      parts = @value.map { |v|
        if v.is_a? Array
          case v[0]
          when :method then v[1].to_java_downcase
          when :constant then v[1].to_java_constant
          else raise ArgumentError
          end
        else
          v
        end
      }
      if @parameters
        # not implemented
      else
        writer.puts "public static int #{@name.to_java_constant} = #{parts.join};", ""
      end
    end
  end

  class PrimitiveType
    def java_name
      case @clang_type
      when :void
        "nil"
      when :bool
        "Boolean"
      when :u_char, :u_short, :u_int, :u_long, :u_long_long, :char_s, :s_char, :short, :int, :long, :long_long
        "Integer"
      when :float, :double
        "Float"
      end
    end

    def java_jna_type
      case @clang_type
      when :void            then "void"
      when :bool            then "boolean"
      when :u_char          then "byte"
      when :u_short         then "short"
      when :u_int           then "int"
      when :u_long          then "NativeLong"
      when :u_long_long     then "long"
      when :char_s, :s_char then "byte"
      when :short           then "short"
      when :int             then "int"
      when :long            then "NativeLong"
      when :long_long       then "long"
      when :float           then "float"
      when :double          then "double"
      end
    end
  end

  class StringType
    def java_name
      "String"
    end

    def java_jna_type
      "String"
    end
  end

  class ByValueType
    def java_name
      @inner_type.java_name
    end

    def java_jna_type
      @inner_type.java_jna_type
    end
  end

  class PointerType
    def java_name
      @pointee_name.to_java_downcase
    end

    def java_jna_type
      "Pointer"
    end

    def java_description
      "FFI::Pointer(#{'*' * @depth}#{@pointee_name ? @pointee_name.to_java_classname : ''})"
    end
  end

  class ArrayType
    def java_name
      "array"
    end

    def java_jna_type
      if @constant_size
        raise
      else
        "#{@element_type.java_jna_type}[]"
      end
    end

    def java_description
      "Array of #{@element_type.java_description}"
    end
  end

  class UnknownType
    def java_name
      "unknown"
    end

    def java_jna_type
      "byte"
    end
  end
end
