module Steven
  class Config

    def initialize
      @config_file = "#{Dir.pwd}/config/config.yml"
      file_contents = YAML.load_file(@config_file) if File.exist?(@config_file)

      if file_contents.is_a?(Hash) && !file_contents.empty?
        @config = file_contents
      else
        initialize_configuration
      end
    end

    def discord_token
      @config[:discord_token]
    end

    def client_id
      @config[:client_id]
    end

    def owner_id
      @config[:owner_id]
    end

    private

    def initialize_configuration
      @config = {}

      puts "No configuration file found in #{Dir.pwd}/config/config.yml"
      puts 'Creating file now...'

      puts 'Enter Discord application token '
      @config[:discord_token] = gets.chomp

      puts 'Enter Discord Client ID '
      @config[:client_id] = gets.chomp

      puts 'Enter owner\'s user ID (press enter for default) '
      @config[:owner_id] = gets.chomp
      @config[:owner_id] = 221687578997424129 if @config[:owner_id].empty?

      save_configurations
    end

    def save_configurations
      File.open(@config_file, 'w') do |f|
        f.write YAML.dump(@config)
      end
    end
  end
end
