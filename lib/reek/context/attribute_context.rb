require_relative 'code_context'

module Reek
  module Context
    #
    # A context wrapper for attribute definitions found in a syntax tree.
    #
    class AttributeContext < CodeContext
      def initialize(context, exp, send_expression)
        @send_expression = send_expression
        super context, exp
      end

      def full_comment
        send_expression.full_comment || ''
      end

      def instance_method?
        true
      end

      # Was this method defined with an instance method-like syntax?
      def defined_as_instance_method?
        true
      end

      private_attr_reader :send_expression
    end
  end
end
