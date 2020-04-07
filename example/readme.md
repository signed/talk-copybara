# copybara

Copybara configuration is written in [Starlark](https://docs.bazel.build/versions/2.2.0/skylark/language.html).
Starlark is a dialect of Python intended for use as a configuration language.
Starlark was formerly known as Skylark and is the language used in [Bazel](https://bazel.build/).

There are multiple implementations from google:
- The [Bazel Starlark](https://github.com/bazelbuild/starlark) ([spec](https://github.com/bazelbuild/starlark/blob/master/spec.md)) implementation in [python](https://www.python.org/).
- The [Starlark](https://github.com/google/starlark-go) ([spec](https://github.com/google/starlark-go/blob/master/doc/spec.md)) implementation in [Go](https://golang.org/).

The documentation speaks of Bazel Starlark being implemented in Java, but the bazel documentation points towards the python repository.
Not sure what to make of this.

# It all starts with a [workflow](https://github.com/google/copybara/blob/master/docs/reference.md#coreworkflow)
The configuration file can contain multiple `workflows`.
Every workflow has a name that has to be passed to the command line to be executed.
If you define a workflow with the name `default` this is the one that will be executed in case you do not explicitly pass a workflow to the cli.  

# Altering files with [transformation]()
Uses [re2](https://github.com/google/re2/wiki/Syntax) to evaludate regular expressions.

# Thoughts and opportunities
- Transformations for modifying `package.json` would be nice ([PR that adds new transformations](https://github.com/google/copybara/commit/ad7acb19949d7a8c4c42ec59f2e19af6ecee2b29))
  - scripts add/remove
  - dependencies add/remove
  - project name
- Documentation is very bare bones or I at least I did not find it
  - bunch of examples and otherwise not structured for on boarding, more reference documentation style
  
# Open Questions
## How can I extend copybara without contributing to the code base? Are there supported extension points?  
