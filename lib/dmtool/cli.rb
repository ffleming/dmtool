module DMTool::CLI
  class << self
    def start
      @parser = DMTool::Parser.new
      ui_loop
      true
    end

    private

    def input
      @input ||= $stdin
    end

    def output
      @output ||= $stdout
    end

    def ui_loop
      prompt do
        while str = input.gets.chomp rescue ''
          break if str.blank?
          begin
            output.puts @parser.parse(str)
          rescue SystemExit => e
            output.puts 'Goodbye'
            break
          rescue => e
            output.puts "#{e.class} #{e.message}"
          end
          prompt
        end
      end
    end

    def prompt
      output.print 'dmtool > '
      yield if block_given?
    end
  end
end
