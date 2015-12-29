require_relative 'code_context'
require_relative 'singleton_method_context'

module Reek
  module Context
    # Semi-transparent context to represent a metaclass while building the
    # context tree. This context will not be part of the resulting tree, but
    # will track context and visibility separately while building is in
    # progress.
    class GhostContext
      attr_reader :children
      private_attr_reader :visibility_tracker

      def initialize(parent, _exp)
        @context = parent
        @children = []
        @visibility_tracker = VisibilityTracker.new
      end

      def append_child_context(child)
        @children << child
        real_parent = @context.append_child_context(child)
        visibility_tracker.set_child_visibility(child)
        real_parent
      end

      # Return the correct class for child method contexts (representing nodes
      # of type `:def`). For GhostContext, this is the class that represents
      # singleton methods.
      def method_context_class
        SingletonMethodContext
      end

      # Return the correct class for child attribute contexts. For
      # GhostContext, this is the class that represents singleton attributes.
      def attribute_context_class
        SingletonAttributeContext
      end

      def module_context?
        true
      end

      def track_visibility(visibility, names)
        visibility_tracker.track_visibility children: children,
                                            visibility: visibility,
                                            names: names
      end

      def track_singleton_visibility(_visibility, _names)
      end

      def record_use_of_self
        @context.record_use_of_self
      end

      def statement_counter
        @context.statement_counter
      end
    end
  end
end
