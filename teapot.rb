
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "2.0"

define_target "generate-project" do |target|
	target.description = <<-EOF
		Generates a basic C++ project.
	EOF
	
	target.depends "Generate/Template"
	target.provides "Generate/Project"
	
	target.build do
		source_path = Build::Files::Directory.new(target.package.path + "templates/project")
		
		substitutions = target.context.substitutions
		
		generate source: source_path, prefix: target.context.root, substitutions: substitutions
	end
end

define_target "generate-project-executable" do |target|
	target.description = <<-EOF
		Generates a basic C++ executable.
	EOF
	
	target.depends "Generate/Template"
	target.provides "Generate/Project/Executable"
	
	target.build do
		source_path = Build::Files::Directory.new(target.package.path + "templates/executable")
		
		substitutions = target.context.substitutions
		
		generate source: source_path, prefix: target.context.root, substitutions: substitutions
	end
end

define_configuration 'generate-project' do |configuration|
	configuration.public!
	
	configuration.require 'generate-template'
	
	configuration.targets[:create] << "Generate/Project"
	configuration.targets[:create] << "Generate/Project/Executable"
end
