require_relative 'code_context'

module Reek
  module Context
    class GhostContext
      attr_reader :children

      def initialize(parent)
        @context = parent
        @children = []
      end

      def append_child_context(child)
        @children << child
        @context.append_child_context(child)
      end
    end
  end
end
