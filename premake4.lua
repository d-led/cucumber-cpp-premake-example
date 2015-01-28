include 'premake'

make_solution 'example'

includedirs {
	'cucumber-cpp-premake/cppspec/include',
	'cucumber-cpp-premake/cucumber-cpp/include',
}

make_console_app('example','features/**.*')

newaction {
	trigger     = "prepare",
	description = "prepare submodules",
	execute     = function ()
		os.execute 'git submodule update --init --recursive'
	end	
}
