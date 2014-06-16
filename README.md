ffi-gen - A generator for Ruby FFI bindings
-------------------------------------------

* **Author:** Richard Musiol, Davide D'Agostino (DAddYE)
* **Contributors:** Jeremy Voorhis (thanks for the initial idea)  
* **License:** MIT (see LICENSE)

**ffi-gen is a completely automatic generator for [FFI](https://github.com/ffi/ffi/wiki) wrappers around C libraries. It uses [LLVM's Clang](http://clang.llvm.org/) compiler as a backend for fully processing the header files of a given library.**

### Features

* Generation of FFI methods, structures, unions, enumerations and callbacks
* Generation of YARD documentation comments
* Tested with headers of the following libraries:
  * Libuv
  * Clang
  * LLVM

### Requirements

* Ruby 2.0
* Clang 3.4.1 (`brew install llvm --with-clang; brew link llvm`)

*These requirements are only for running the generator. The generated files are Ruby 2.0 compatible and do not need Clang.*


### Example

Use the following interface in a script or Rake task:

    require "ffi/gen"

    FFI::Gen.generate(
      module_name:  "FFI::Gen::Clang",
      require_path: "ffi/en/clang",
      ffi_lib:      "'clang'",
      headers:      ["clang-c/CXString.h", "clang-c/Index.h"],
      cflags:       `llvm-config --cflags`.split(" "),
      prefixes:     ["clang_", "CX"],
      output:       File.join(File.dirname(__FILE__), "gen/clang.rb")
    )

Output: [clang.rb](https://github.com/DAddYE/ffi-gen/blob/master/lib/ffi/gen/clang.rb)

Other generated files can be found in the [clang](https://github.com/DAddYE/ffi-gen/tree/master/lib/ffi/gen/clang) directory.

### Hints

You may need to set additional include directories:

    export CPATH=/usr/lib/gcc/x86_64-linux-gnu/4.6.1/include

Your GCC include paths can be seen with:

    `gcc -print-prog-name=cc1` -v

What is `require_path`? It's used to autoload files, see
[here](https://github.com/DAddYE/ffi-gen/blob/master/lib/ffi/gen/clang.rb#L8-L43)

### Projects using ffi_gen

* https://github.com/jvoorhis/ruby-llvm
* https://github.com/daddye/uv
* https://github.com/daddye/leveldb

Roadmap
-------

* Automatic generation of object oriented wrappers
* Polish YARD documentation comments some more


Feedback
--------
Please use GitHub's issue tracker for problems or suggestions. Pull requests are welcome, too.
