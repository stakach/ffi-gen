class FFI::Gen
  def generate_rb
    writer = Writer.new "  ", "# "
    writer.puts "require 'fiddler'", ""
    writer.puts "module #{@module_name}"
    writer.indent do
      writer.puts "module C"
      writer.indent do
        writer.puts "include Fiddler"
        # writer.puts "ffi_lib_flags #{@ffi_lib_flags.map(&:inspect).join(', ')}" if @ffi_lib_flags

        writer.puts "", "prefix '#{@prefixes.first}'"
        writer.puts "dlload #{@ffi_lib}", "" if @ffi_lib

        # [Enum, StructOrUnion].each do |kind|
        #   writer.puts "##"
        #   writer.puts "# Writing #{kind}"
        #   writer.puts "#"
        #   empty = !declarations.any?{ |d| d.kind_of?(kind) }
        #   while not empty
        #     empty = true
        #     declarations.each do |declaration|
        #       next unless declaration.kind_of?(kind)
        #       declaration.write_ruby writer
        #       declarations.delete declaration
        #       empty = false
        #     end
        #   end
        # end

        # writer.puts "##"
        # writer.puts "# Writing Callbacks"
        # writer.puts "#"
        # declarations.select(&:is_callback).each do |declaration|
        #   declaration.write_ruby writer
        #   declarations.delete declaration
        # end

        # writer.puts "##"
        # writer.puts "# Writing Functions"
        # writer.puts "#"
        declarations.sort_by(&:ruby_name).each do |declaration|
          declaration.write_ruby writer
        end
      end
      writer.puts "end"
    end
    writer.puts "end"
    writer.output
  end

  class Name
    RUBY_KEYWORDS = %w{alias and begin break case class def defined do else elsif end ensure false for if in module next nil not or redo rescue retry return self super then true undef unless until when while yield BEGIN END}

    def to_ruby_downcase
      format :downcase, :underscores, RUBY_KEYWORDS
    end

    def to_ruby_classname
      format :camelcase, RUBY_KEYWORDS
    end

    def to_ruby_constant
      format :upcase, :underscores, RUBY_KEYWORDS
    end
  end

  class Type
    def ruby_description
      ruby_name
    end
  end

  class Enum
    def write_ruby(writer)
      return if @name.nil?
      shorten_names

      @constants.each do |constant|
        constant[:symbol] = constant[:name].to_ruby_downcase.
                                            to_sym.
                                            inspect
      end

      # writer.comment do
      #   writer.write_description @description
      #   writer.puts "", "_This entry is only for documentation and no real method. The FFI::Enum can be accessed via `#enum_type(:#{ruby_name})`._"
      #   writer.puts "", "## Options:"
      #   @constants.each do |constant|
      #     writer.puts "#{constant[:symbol]} ::"
      #     writer.write_description constant[:comment], false, "  ", "  "
      #   end
      #   writer.puts "", "@method `enum_#{ruby_name}`", "@return [Symbol]", "@scope class", ""
      # end

      writer.puts "#{ruby_name} = Hash["
      writer.indent do
        writer.write_array @constants, "," do |constant|
          "#{constant[:symbol]}, #{constant[:value]}"
        end
      end
      writer.puts "]", ""
    end

    def ruby_name
      @ruby_name ||= @name ? @name.to_ruby_classname : ''
    end

    def ruby_ffi_type
      "INT"
    end

    def ruby_description
      "Symbol from `enum_#{ruby_name}`"
    end
  end

  class StructOrUnion
    def write_ruby(writer)
      # writer.comment do
      #   writer.write_description @description
      #   unless @fields.empty?
      #     writer.puts "", "## Fields:"
      #     @fields.each do |field|
      #       writer.puts ":#{field[:name].to_ruby_downcase} ::"
      #       writer.write_description field[:comment], false, "  (#{field[:type].ruby_description}) ", "  "
      #     end
      #   end
      # end

      # @fields << { name: Name.new(["dummy"]), type: PrimitiveType.new(:char_s) } if @fields.empty?

      # unless @oo_functions.empty?
      #   writer.puts "module #{ruby_name}Wrappers"
      #   writer.indent do
      #     @oo_functions.each_with_index do |(name, function), index|
      #       parameter_names = function.parameters[1..-1].map { |parameter| parameter[:name].to_ruby_downcase }
      #       fn_name = name.to_ruby_downcase
      #       fn_name = function.ruby_name if fn_name.empty?
      #       writer.puts "" unless index == 0
      #       writer.comment do
      #         function.parameters[1..-1].each do |parameter|
      #           writer.write_description parameter[:description], false, "@param [#{parameter[:type].ruby_description}] #{parameter[:name].to_ruby_downcase} ", "  "
      #         end
      #         return_type = function.return_type.is_a?(StructOrUnion) ? function.return_type.ruby_name : function.return_type.ruby_description
      #         writer.write_description function.return_value_description, false, "@return [#{return_type}] ", "  "
      #       end
      #       writer.puts "def #{fn_name}(#{parameter_names.join(', ')})"
      #       writer.indent do
      #         cast = function.return_type.is_a?(StructOrUnion) ? "#{function.return_type.ruby_name}.new " : ""
      #         writer.puts "#{cast}#{@generator.module_name}.#{function.ruby_name}(#{(["self"] + parameter_names).join(', ')})"
      #       end
      #       writer.puts "end"
      #     end
      #   end
      #   writer.puts "end", ""
      # end

      # writer.puts "class #{ruby_name} < #{@is_union ? 'FFI::Union' : 'FFI::Struct'}"
      # writer.indent do
      #   writer.puts "include #{ruby_name}Wrappers" unless @oo_functions.empty?
      #   writer.write_array @fields, ",", "layout ", "       " do |field|
      #     ":#{field[:name].to_ruby_downcase}, #{field[:type].ruby_ffi_type}"
      #   end
      # enda
      # writer.puts "end", ""

      writer.puts "#{ruby_name} = struct [#{@fields.map { |f| "'#{f[:type].c_type} #{f[:type].name.to_ruby_downcase}" }.join("', ")}']"

      # @written = true
    end

    def ruby_name
      @ruby_name ||= @name.to_ruby_classname
    end

    def ruby_ffi_type
      "VOIDP"
      # @written ? ruby_name : ":pointer"
    end

    def ruby_description
      "Fiddle::Pointer(*#{ruby_name})"
    end
  end


  class FunctionOrCallback
    def write_ruby(writer)
      # writer.puts "@blocking = true" if @blocking
      # writer.comment do
      #   writer.write_description @function_description
      #   writer.puts "", "_This entry is only for documentation and no real method._" if @is_callback
      #   writer.puts "", "@method #{@is_callback ? "`callback_#{ruby_name}`" : ruby_name}(#{@parameters.map{ |parameter| parameter[:name].to_ruby_downcase }.join(', ')})"
      #   @parameters.each do |parameter|
      #     writer.write_description parameter[:description], false, "@param [#{parameter[:type].ruby_description}] #{parameter[:name].to_ruby_downcase} ", "  "
      #   end
      #   writer.write_description @return_value_description, false, "@return [#{@return_type.ruby_description}] ", "  "
      #   writer.puts "@scope class", ""
      # end

      blocking = @blocking ? ', blocking: true' : ''
      ffi_signature = ", #{@parameters.map { |r| "#{r[:name].to_ruby_downcase || r[:type].ruby_name}: #{r[:type].ruby_ffi_type}" }.join(', ')}" unless @parameters.empty?
      # if @is_callback
      #   writer.puts "callback :#{ruby_name}, #{ffi_signature}", ""
      # else
      #   writer.puts "attach_function :#{ruby_name}, :#{@name.raw}, #{ffi_signature}", ""
      # end
      writer.puts "cdef :#{ruby_name}, #{@return_type.ruby_ffi_type}#{ffi_signature}#{blocking}"
    end

    def ruby_name
      @ruby_name ||= @name.to_ruby_downcase
    end

    def ruby_ffi_type
      ruby_name.upcase
    end

    def ruby_description
      "Proc(callback_#{ruby_name})"
    end
  end

  # class Define
  #   def write_ruby(writer)
  #     parts = @value.map { |v|
  #       if v.is_a? Array
  #         case v[0]
  #         when :method then v[1].to_ruby_downcase
  #         when :constant then v[1].to_ruby_constant
  #         else raise ArgumentError
  #         end
  #       else
  #         v
  #       end
  #     }
  #     if @parameters
  #       writer.puts "def #{@name.to_ruby_downcase}(#{@parameters.join(", ")})"
  #       writer.indent do
  #         writer.puts parts.join
  #       end
  #       writer.puts "end", ""
  #     else
  #       writer.puts "#{@name.to_ruby_constant} = #{parts.join}", ""
  #     end
  #   end
  # end

  class Type
    def c_type(ffi_type=ruby_ffi_type)
      case ffi_type
      when 'VOID'    then 'void'
      when 'UCHAR'   then 'unsigned char'
      when 'USHORT'  then 'unsigned short'
      when 'UINT'    then 'unsigned int'
      when 'ULONG'   then 'unsigned float'
      when 'ULLONG'  then 'unsigned float float'
      when 'CHAR'    then 'char'
      when 'SHORT'   then 'short'
      when 'INT'     then 'int'
      when 'LONG'    then 'long'
      when 'LLONG'   then 'long long'
      when 'FLOAT'   then 'float'
      when 'DOUBLE'  then 'double'
      when 'VOIDP'   then '*void'
      when /\[/      then '*void'
      else ffi_type
      end
    end
  end

  class PrimitiveType
    def ruby_name
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

    def ruby_ffi_type
      case @clang_type
      when :void            then "VOID"
      when :bool            then "BOOL"
      when :u_char          then "UCHAR"
      when :u_short         then "USHORT"
      when :u_int           then "UINT"
      when :u_long          then "ULONG"
      when :u_long_long     then "ULLONG"
      when :char_s, :s_char then "CHAR"
      when :short           then "SHORT"
      when :int             then "INT"
      when :long            then "LONG"
      when :long_long       then "LLONG"
      when :float           then "FLOAT"
      when :double          then "DOUBLE"
      end
    end
  end

  class StringType
    def ruby_name
      "String"
    end

    def ruby_ffi_type
      "VOIDP"
    end
  end

  class ByValueType
    def ruby_name
      @inner_type.ruby_name
    end

    def ruby_ffi_type
      "#{@inner_type.ruby_ffi_type}" # .by_value
    end
  end

  class TypedefType
    def ruby_name
      parent.ruby_name
    end

    def ruby_ffi_type
      parent.to_ruby_classname
    end

    def write_ruby(writer)
    end
  end

  class PointerType
    def ruby_name
      @pointee_name ? @pointee_name.ruby_name : aliases[0]
    end

    def ruby_ffi_type
      "VOIDP"
    end

    def ruby_description
      "Fiddle::Pointer(#{'*' * @depth}#{raw})"
    end
  end

  class ArrayType
    def ruby_name
      "Array"
    end

    def ruby_ffi_type
      if @constant_size
        "[#{@element_type.ruby_ffi_type}, #{@constant_size}]"
      else
        "VOIDP"
      end
    end

    def ruby_description
      "Array<#{@element_type.ruby_description}>"
    end
  end

  class UnknownType
    def ruby_name
      "Unknown"
    end

    def ruby_ffi_type
      "CHAR"
    end
  end

end
