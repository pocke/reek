require_relative '../../spec_helper'
require_lib 'reek/context/code_context'
require_lib 'reek/context/ghost_context'

RSpec.describe Reek::Context::GhostContext do
  let(:exp) { double('exp') }
  let(:parent) { Reek::Context::CodeContext.new(nil, exp) }

  describe '#initialize' do
    it 'does not append itself to its parent' do
      ghost = described_class.new(parent)
      expect(parent.children).not_to include ghost
    end
  end

  describe '#append_child_context' do
    let(:ghost) { described_class.new(parent) }

    it 'appends the child to the grandparent context' do
      child = Reek::Context::CodeContext.new(ghost, double('exp2'))

      expect(parent.children).to include child
    end

    it "sets the child's parent to the grandparent context" do
      child = Reek::Context::CodeContext.new(ghost, double('exp2'))

      expect(child.context).to eq parent
    end

    it 'appends the child to the list of children' do
      child = Reek::Context::CodeContext.new(ghost, double('exp2'))

      expect(ghost.children).to include child
    end
  end
end
