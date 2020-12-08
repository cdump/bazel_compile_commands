# Example

Usage example of [bazel-compile-commands](linkplz)

See comments in [WORKSPACE](WORKSPACE), [BUILD.bazel](BUILD.bazel) and [.bazelrc](.bazelrc)

# How to build

```sh
bazel build '@//:example'
bazel run '@bazel_compile_commands//:gen_compile_commands.sh'
```

You need to run `bazel run '@bazel_compile_commands//:gen_compile_commands.sh'` only when project changes: new dependency, changed build options, etc.
