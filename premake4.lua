include 'premake'

required_recipes = {
	'recipes.cucumber-cpp'
}

include 'cucumber-cpp-premake'

make_solution 'example'

make_console_app('example','features/**.*')

newaction {
	trigger     = "prepare",
	description = "prepare submodules",
	execute     = function ()
		os.execute 'git submodule update --init --recursive'
	end	
}
