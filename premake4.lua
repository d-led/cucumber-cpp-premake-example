include 'premake'

make_solution 'example'

cucumber_cpp_root = './cucumber-cpp-premake'

local function cucumber_cpp_path(dir)
	return path.join(cucumber_cpp_root,dir)
end

includedirs {
	cucumber_cpp_path('cppspec/include'),
	cucumber_cpp_path('cucumber-cpp/include'),
}

----------------------------------------------------------------------------------------------------------------
make_static_lib('cucumber-cpp', {
	cucumber_cpp_path 'cucumber-cpp/src/*.cpp',
	cucumber_cpp_path 'cucumber-cpp/src/connectors/wire/*.cpp'
})
	excludes { cucumber_cpp_path 'cucumber-cpp/src/main.cpp' }
----------------------------------------------------------------------------------------------------------------
make_static_lib('cucumber-cpp-main', { cucumber_cpp_path 'cucumber-cpp/src/main.cpp' })
----------------------------------------------------------------------------------------------------------------
make_static_lib('cppspec',{cucumber_cpp_path 'cppspec/src/*.cpp' } )
----------------------------------------------------------------------------------------------------------------
make_static_lib('cucumber-cpp-cppspec-driver', { cucumber_cpp_path 'cucumber-cpp/src/drivers/CppSpecDriver.cpp' })
----------------------------------------------------------------------------------------------------------------

local cucumber_steps = assert( require ( cucumber_cpp_path 'recipes/cucumber-steps' ) )

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
		local util = assert( require ( cucumber_cpp_path 'recipes/util' ) )
		util.start_cucumber {
			start_in = '.' ,
			executable = 'example'
		}
	end
}
