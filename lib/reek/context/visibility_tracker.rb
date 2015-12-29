require 'private_attr/everywhere'

module Reek
  module Context
    # Responsible for tracking visibilities in regards to CodeContexts.
    class VisibilityTracker
      private_attr_accessor :tracked_visibility

      INSTANCE_METHOD_NODE_TYPES = [:sym, :def]

      def initialize
        @tracked_visibility = :public
      end

      # Handle the effects of a visibility modifier.
      #
      # @example Modifying the visibility of existing children
      #   track_visibility children, :private, [:hide_me, :implementation_detail]
      #
      # @param children [Array<CodeContext>]
      # @param visibility [Symbol]
      # @param names [Array<Symbol>]
      #
      def track_visibility(children: raise, visibility: raise, names: raise)
        if names.any?
          children.each do |child|
            child.visibility = visibility if names.include?(child.name)
          end
        else
          self.tracked_visibility = visibility
        end
      end

      # Sets the visibility of a child CodeContext to the tracked visibility.
      #
      # @param child [CodeContext]
      #
      def set_child_visibility(child)
        return unless INSTANCE_METHOD_NODE_TYPES.include? child.type
        child.visibility = tracked_visibility
      end

      VISIBILITY_MAP = { public_class_method: :public, private_class_method: :private }

      def map_singleton_visibility(visibility)
        VISIBILITY_MAP[visibility]
      end
    end
  end
end
