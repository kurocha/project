
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "0.7"

define_generator "project" do |generator|
	generator.description = <<-EOF
		Generates a basic project for use with the dream-framework.
	EOF
	
	generator.generate do |project_name|
		source_path = Pathname("source/#{project_name}")
		test_path = Pathname("test/")
		
		name = Teapot::Name.new(project_name)
		
		substitutions = {
			# e.g. Foo Bar, typically used as a title, directory, etc.
			'$PROJECT_NAME' => name.text,
			
			# e.g. FooBar, typically used as a namespace
			'$PROJECT_IDENTIFIER' => name.identifier,
			
			# e.g. foo-bar, typically used for targets, executables
			'$PROJECT_TARGET_NAME' => name.target,
			
			# The user's current name:
			'$AUTHOR_NAME' => `git config --global user.name`.chomp!
		}
		
		generator.copy('templates/project', '.', substitutions)
	end
end

define_configuration "project" do |configuration|
	configuration.public!

	configuration.import 'dream-framework'
end

define_configuration "dream-framework" do |configuration|
	configuration.public!

	# Provides variant-debug and variant-release:
	configuration.require "variants"

	# Provides suitable packages for building on darwin:
	host /darwin/ do
		configuration.require "platform-darwin-osx"
		configuration.require "platform-darwin-ios"
	end

	# Provides suitable packages for building on linux:
	host /linux/ do
		configuration.require "platform-linux"
	end

	# Provides suitable packages for building on windows:
	host /windows/ do
		configuration.require "platform-windows"
	end

	configuration.require "png"
	configuration.require "jpeg"
	
	configuration.require "freetype"
	
	configuration.require "ogg"
	configuration.require "vorbis"

	# Unit testing
	configuration.require "unit-test"
	
	configuration.require "euclid"
	
	configuration.require "dream"
end
