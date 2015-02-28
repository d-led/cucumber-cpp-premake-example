#include <CppSpec.h>
#include <cucumber-cpp/defs.hpp>
#include <string>

using cucumber::ScenarioScope;

struct EchoServiceRunner {
	std::string request;
	std::string reply;
	void calculate() {
		reply = request;
	}
};

GIVEN("^an echo service$") {
    ScenarioScope<EchoServiceRunner> context;
}


WHEN("^I send (.*)$") {
    ScenarioScope<EchoServiceRunner> context;
    REGEX_PARAM(std::string, request);
    context->request = request;
}


THEN("^I get (.*)$") {
    ScenarioScope<EchoServiceRunner> context;
    REGEX_PARAM(std::string, reply);
    
    context->calculate();

    specify(context->reply, should.equal(reply));
}
