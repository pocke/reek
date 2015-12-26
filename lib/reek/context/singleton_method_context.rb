require_relative 'method_context'

module Reek
  module Context
    #
    # A context wrapper for any singleton method definition found in a syntax tree.
    #
    class SingletonMethodContext < MethodContext
      def singleton_method?
        true
      end

      def module_function?
        false
      end
    end
  end
end
