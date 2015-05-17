module CoreExtensions
  module String
    module Prep
      def prep
        self.strip.squeeze(', ')
      end
    end
  end
end
