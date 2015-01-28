include 'premake'

make_solution 'example'

cucumber_cpp_root = './cucumber-cpp-premake'

dofile 'cucumber-cpp.lua'

local cucumber_steps = assert( require ( path.join(cucumber_cpp_root, 'recipes/cucumber-steps') ) )

cucumber_steps.make_cppspec_steps ('example',{'features/**.*'}, '.')

newaction {
	trigger     = 'prepare',
	description = 'prepare submodules',
	execute     = function ()
		os.execute 'git submodule update --init --recursive'
	end	
}

newaction {
	trigger     = 'cucumber',
	description = 'run cucumber tests',
	execute     = function ()
		local util = assert( require ( path.join(cucumber_cpp_root, 'recipes/util') ) )
		util.start_cucumber {
			start_in = '.' ,
			executable = 'example'
		}
	end
}
