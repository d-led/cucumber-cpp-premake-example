include 'premake'

boost = assert(dofile 'premake/recipes/boost.lua')

local OS = os.get()

make_solution 'example'

configuration 'windows'
	defines { 
		'_WIN32_WINNT=0x0501',
		'WIN32',
	}
configuration '*'

includedirs {
	boost.includedirs[OS]
}

boost:set_libdirs()

cucumber_cpp_root = './cucumber-cpp-premake'

dofile 'cucumber-cpp.lua'

local cucumber_steps = assert( require ( path.join(cucumber_cpp_root, 'recipes/cucumber-steps') ) )

cucumber_steps.make_cppspec_steps ('example',{'features/**.*'}, '.')

links {
	boost.links[OS]
}

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
