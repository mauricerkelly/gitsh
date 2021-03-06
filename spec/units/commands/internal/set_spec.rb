require 'spec_helper'
require 'gitsh/commands/internal_command'

describe Gitsh::Commands::InternalCommand::Set do
  it_behaves_like "an internal command"

  describe '#execute' do
    it 'sets a variable on the environment' do
      env = stub('env', :[]=)
      command = described_class.new(env, 'set', %w(foo bar))

      command.execute

      expect(env).to have_received(:[]=).with('foo', 'bar')
    end

    it 'returns true with correct arguments' do
      env = stub(:[]= => true, puts_error: true)
      command = described_class.new(env, 'set', %w(foo bar))

      expect(command.execute).to be_true
    end

    it 'returns false with invalid arguments' do
      env = stub(:[]= => true, puts_error: true)
      command = described_class.new(env, 'set', %w(foo))

      expect(command.execute).to be_false
    end
  end
end
