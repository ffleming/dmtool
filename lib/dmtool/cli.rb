module DMTool::CLI
  class << self
    def start
      options = opts_from_cli

      trap 'SIGINT' do
        exit
      end

      @parser = DMTool::Parser.new
      ui_loop
    end

    private

    def ui_loop
      prompt do
        while str = gets.chomp rescue ''
          break if str.blank?
          begin
            puts @parser.parse(str)
          rescue => e
            puts "#{e.class} #{e.message}"
          end
          prompt
        end
      end
    end

    def prompt
      print 'dmtool > '
      yield if block_given?
    end

    def opts_from_cli
      options = {}
      opt_parser = OptionParser.new do |opts|
        opts.program_name = File.basename(__FILE__)
        opts.banner = "#{opts.program_name} [options]"
        opts.on('-v', '--version', 'Print version information') do
          puts "#{File.basename(__FILE__)} #{DMTool::VERSION}"
          exit true
        end
        opts.on('-h', '--help', 'Display this screen') do
          puts opts
          exit true
        end
      end
      begin
        opt_parser.parse!
      rescue OptionParser::InvalidOption => e
        puts e.message
        exit false
      end
      options
    end

  end
end
