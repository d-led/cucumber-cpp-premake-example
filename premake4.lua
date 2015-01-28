include 'premake'

make_solution 'example'

includedirs {
	'cucumber-cpp-premake/cppspec/include',
	'cucumber-cpp-premake/cucumber-cpp/include',
}

----------------------------------------------------------------------------------------------------------------
make_static_lib('cucumber-cpp', {
	'./cucumber-cpp-premake/cucumber-cpp/src/*.cpp',
	'./cucumber-cpp-premake/cucumber-cpp/src/connectors/wire/*.cpp'
})
	excludes { './cucumber-cpp-premake/cucumber-cpp/src/main.cpp' }
----------------------------------------------------------------------------------------------------------------
make_static_lib("cucumber-cpp-main", { "./cucumber-cpp-premake/cucumber-cpp/src/main.cpp" })
----------------------------------------------------------------------------------------------------------------
make_static_lib('cppspec',{'./cucumber-cpp-premake/cppspec/src/*.cpp'} )
----------------------------------------------------------------------------------------------------------------
make_static_lib('cucumber-cpp-cppspec-driver', { './cucumber-cpp-premake/cucumber-cpp/src/drivers/CppSpecDriver.cpp' })
----------------------------------------------------------------------------------------------------------------

local cucumber_steps = assert( require 'cucumber-cpp-premake/recipes/cucumber-steps' )

cucumber_steps.make_cppspec_steps ('example',{'features/**.*'}, '.')

newaction {
	trigger     = 'prepare',
	description = 'prepare submodules',
	execute     = function ()
		os.execute 'git submodule update --init --recursive'
	end	
}

newaction {
	trigger     = "cucumber",
	description = "run cucumber tests",
	execute     = function ()
		local util = assert( require 'cucumber-cpp-premake/recipes/util' )
		util.start_cucumber {
			start_in = '.' ,
			executable = 'example'
		}
	end
}
