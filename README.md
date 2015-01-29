cucumber-cpp premake example
============================

This project is intended as a starting point for assessing [cucumber-cpp](https://github.com/cucumber/cucumber-cpp) in order to write BDD-style tests in C++ projects as steps for [cucumber](http://cukes.info/). All dependencies can be easily built for all major platforms using an aggregating meta-build project, [cucumber-cpp-premake](https://github.com/d-led/cucumber-cpp-premake).

building
--------
- Check out the recursive submodules: `premake\premake4 prepare`.
- Generate the build using [premake](https://bitbucket.org/premake/premake-dev/wiki/Home): `premake\premake4 _target_`
- Build
- Start the test: `premake\premake4 cucumber`

overview
--------

- [features](features) contains the gherkin features
- [step_definitions](features/step_definitions) contains the [wire config](features/step_definitions/cucumber.wire) for gherkin and the steps [implementation](features/step_definitions/simple_steps.cpp)
- [cppspec](https://github.com/tpuronen/cppspec) and a [cppspec driver](https://github.com/d-led/cucumber-cpp/blob/master/src/drivers/CppSpecDriver.cpp) is used for bdd-style assertions
- The compiled executable acts as a server that is controlled by [cucumber](http://cukes.info/)
