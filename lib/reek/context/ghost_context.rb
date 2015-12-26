require_relative 'code_context'

module Reek
  module Context
    class GhostContext < CodeContext
      def initialize(parent)
        @context = parent
      end

      def append_child_context(child)
        @context.append_child_context(child)
      end
    end
  end
end
